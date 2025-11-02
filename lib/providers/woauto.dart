import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/wa_ext.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// The WoAuto GetXController class
class WoAuto extends GetxController {
  final currentPosition = const CameraPosition(
    target: LatLng(
      37.42796133580664,
      -122.085749655962,
    ),
    zoom: 16,
  ).obs;

  final currentSelectedPosition = Rxn<LatLng>();
  final currentSelectedCarPark = Rxn<CarPark>();

  final carParkings = <CarPark>[].obs;
  final friendPositions = <CarPark>[].obs;
  RxList<Marker> get friendPositionMarkers =>
      friendPositions.map((park) => makeCarMarker(park)).toList().obs;
  final friendCarPositions = <CarPark>[].obs;
  RxList<Marker> get friendCarMarkers =>
      friendCarPositions.map((park) => makeCarMarker(park)).toList().obs;
  RxList<Marker> get carMarkers =>
      carParkings.map((park) => makeCarMarker(park)).toList().obs;
  final tempMarkers = <Marker>{}.obs;
  final carParkingHistory = <CarPark>[].obs;

  final mapController = Rxn<GoogleMapController?>();

  final welcome = true.obs;

  final appVersion = ''.obs;
  final appBuildNumber = ''.obs;
  final currentIndex = 0.obs;
  final drivingMode = false.obs;
  final askForDrivingMode = true.obs;

  // settings
  final themeMode = 0.obs;
  final appColor = appColorDefault.getValue.obs;
  final mapType = MapType.normal.obs;
  final showTraffic = false.obs;
  final drivingModeDetectionSpeed = 20.obs;

  // my car data
  final subText = 'Mein Auto'.obs;
  final kennzeichen = ''.obs;
  final kilometerStand = ''.obs;
  final tuvUntil = DateTime.now().obs;
  final carPicture = ''.obs;
  final carBaujahr = ''.obs;

  // data
  final currentVelocity = 0.0.obs;

  late SharedPreferences sp;

  Future<SharedPreferences> get prefs async {
    return sp;
  }

  WoAuto(this.sp);

  @override
  void onClose() {
    super.onClose();
    // Dispose controllers
    mapController.value?.dispose();
  }

  // to json string
  String toJson() {
    return json.encode({
      'subText': subText.value,
      'kennzeichen': kennzeichen.value,
      'kilometerStand': kilometerStand.value,
      'tuvUntil': tuvUntil.value.toIso8601String(),
      'carPicture': carPicture.value,
      'carPictureDate': carBaujahr.value,
      'themeMode': themeMode.value,
      'appColor': appColor.value.toString(),
      'carParkings': carParkings.map((e) => e.toJson()).toList(),
      'carParkHistory': carParkingHistory.map((e) => e.toJson()).toList(),
      'welcome': welcome.value,
      'drivingModeDetectionSpeed': drivingModeDetectionSpeed.value,
    });
  }

  // from json string
  static Future<WoAuto> fromJson(String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    WoAuto woAuto = WoAuto(await SharedPreferences.getInstance());

    woAuto.welcome.value = jsonMap['welcome'] ?? true;
    woAuto.drivingModeDetectionSpeed.value =
        jsonMap['drivingModeDetectionSpeed'] ?? 20;

    var carParkings = jsonMap['carParkings'] ?? [];
    for (int i = 0; i < carParkings.length; i++) {
      var park = CarPark.fromJson(carParkings[i]);
      if (park.mine) {
        woAuto.carParkings.add(park);
      }
    }

    woAuto.carParkings.refresh();
    woAuto.carMarkers.refresh();
    var carParkingHistory = jsonMap['carParkHistory'] ?? [];
    for (int i = 0; i < carParkingHistory.length; i++) {
      woAuto.carParkingHistory.add(CarPark.fromJson(carParkingHistory[i]));
    }

    if (woAuto.carParkings.isNotEmpty) {
      var myCar = woAuto.carParkings.first;
      woAuto.currentPosition.value = CameraPosition(
        target: myCar.latLng,
        zoom: 16,
      );
    }

    woAuto.subText.value = jsonMap['subText'] ?? t.constants.default_park_title;
    woAuto.kennzeichen.value = jsonMap['kennzeichen'] ?? '';
    woAuto.kilometerStand.value = jsonMap['kilometerStand'] ?? '';
    woAuto.tuvUntil.value =
        DateTime.parse(jsonMap['tuvUntil'] ?? DateTime.now().toIso8601String());
    woAuto.carPicture.value = jsonMap['carPicture'] ?? '';
    woAuto.carBaujahr.value =
        jsonMap['carPictureDate'] ?? DateTime.now().year.toString();
    // settings
    woAuto.themeMode.value = jsonMap['themeMode'] ?? 0;
    woAuto.appColor.value =
        int.parse(jsonMap['appColor'] ?? appColorDefault.getValue.toString());

    return woAuto;
  }

  // save to local storage
  Future<void> save() async {
    var sp = await prefs;
    sp.setString('woauto', toJson());
  }

  // load from local storage
  static Future<WoAuto> load() async {
    var sp = await SharedPreferences.getInstance();
    String? jsonString = sp.getString('woauto');
    WoAuto woAuto;
    if (jsonString == null) {
      woAuto = WoAuto(sp);
    } else {
      woAuto = await fromJson(jsonString);
    }
    woAuto.fetchPackageInfo();

    return woAuto;
  }

  /// Bebug the current state of the Appmelder
  void printWoAuto() {
    logMessage('WoAuto');
    logMessage('App Version: $appVersion');
    logMessage('App Build Number: $appBuildNumber');

    logMessage('Current Position: ${currentPosition.value}');
    logMessage('Current Velocity: $currentVelocity');

    logMessage('Welcome: $welcome');
    logMessage('Driving Mode: $drivingMode');
    logMessage('Ask for Driving Mode: $askForDrivingMode');

    logMessage('CarPark History length: ${carParkingHistory.length}');
    logMessage('CarParkings length: ${carParkings.length}');
    // logMessage('CarParkings: ${carParkings.map((e) => e.toJson())}');
    // logMessage('Keys begin');
    // logMessage('CarParkings: ${carParkings.map((e) => e.editKey)}');
    // logMessage('CarParkings: ${carParkings.map((e) => e.viewKey)}');
    // logMessage('Keys end');
    logMessage('CarMarkers length: ${carMarkers.length}');
    // logMessage('CarMarkers: ${carMarkers.map((e) => e.toJson())}');
    logMessage('TempMarkers length: ${tempMarkers.length}');
    // logMessage('TempMarkers: ${tempMarkers.map((e) => e.toJson())}');

    logMessage('Subtext: $subText');
    logMessage('Kennzeichen: $kennzeichen');
    logMessage('Kilometerstand: $kilometerStand');
    logMessage('TÜV: $tuvUntil');
    logMessage('Car Picture: $carPicture');
    logMessage('Car Baujahr: $carBaujahr');

    logMessage('Theme Mode: $themeMode');
    logMessage('Map Type: $mapType');
    logMessage('Show Traffic: $showTraffic');
    logMessage('Driving Mode Detection Speed: $drivingModeDetectionSpeed');

    logMessage('---' * 15);
  }

  /// Resets the WoAuto provider
  Future<void> reset() async {
    subText.value = t.constants.default_park_title;
    kennzeichen.value = '';
    kilometerStand.value = '';
    tuvUntil.value = DateTime.now();
    carPicture.value = '';
    carBaujahr.value = DateTime.now().year.toString();

    themeMode.value = 0;
    appColor.value = appColorDefault.getValue;
    drivingModeDetectionSpeed.value = 20;

    carParkings.clear();
    carParkingHistory.clear();
    tempMarkers.clear();

    sp.clear();
    welcome.value = true;
    currentIndex.value = 0;

    woAuto.save();
  }

  void setTheme() {
    var brightness = woAuto.themeMode.value == 0
        ? Get.mediaQuery.platformBrightness
        : woAuto.themeMode.value == 1
            ? Brightness.light
            : Brightness.dark;
    Get.changeTheme(
      ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(appColor.value),
          brightness: brightness,
        ),
        useMaterial3: true,
        brightness: brightness,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }

  Future<void> onNewParking(LatLng newPosition) async {
    if (kDebugMode) {
      woAuto.printWoAuto();
    }
    var textController = TextEditingController();
    var newNameController =
        TextEditingController(text: woAuto.subText.value).obs;
    var focusNode = FocusNode();
    var carPicturePath = ''.obs;

    await Get.dialog(
      GestureDetector(
        onTap: () => FocusScope.of(Get.context!).unfocus(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(t.park_dialog.title),
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          content: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(t.park_dialog.content_1),
                  ),
                  ListTile(
                    title: Autocomplete<String>(
                      optionsBuilder: (textEditingValue) {
                        var search = textEditingValue.text;
                        // print(search);
                        if (search.isEmpty) return [];

                        List<String> carNames = carParkings
                            .where(
                              (element) => element.name
                                  .toLowerCase()
                                  .startsWith(search.toLowerCase()),
                            )
                            .map((e) => e.name)
                            .toList();

                        return carNames;
                      },
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onFieldSubmitted: (s) => onFieldSubmitted,
                          onChanged: (s) {
                            newNameController.refresh();
                          },
                        );
                      },
                      textEditingController: newNameController.value,
                      focusNode: focusNode,
                    ),
                    trailing: IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: newNameController.value.text.isNotEmpty
                          ? () {
                              newNameController.value.clear();
                              newNameController.refresh();
                            }
                          : null,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  10.h,
                  ExpandablePanel(
                    header: ListTile(
                      title: Text(t.park_dialog.content_2),
                    ),
                    collapsed: const SizedBox(),
                    expanded: Column(
                      children: [
                        ListTile(
                          title: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: t.park_dialog.info.label,
                              hintText: t.constants.default_park_info,
                            ),
                          ),
                        ),
                        16.h,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  Get.bottomSheet(
                                    Card(
                                      color: Get.theme.colorScheme.surface,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                      margin: EdgeInsets.zero,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title:
                                                    Text(t.bottom_sheet.camera),
                                                leading:
                                                    const Icon(Icons.camera_alt),
                                                onTap: () async {
                                                  pop();
                                                  XFile? image =
                                                      await ImagePicker()
                                                          .pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                          
                                                  if (image == null) return;
                                          
                                                  String duplicateFilePath =
                                                      (await getApplicationDocumentsDirectory())
                                                          .path;
                                          
                                                  var fileName =
                                                      image.path.split('/').last;
                                                  File localImage =
                                                      await File(image.path).copy(
                                                    '$duplicateFilePath/$fileName',
                                                  );
                                                  carPicturePath.value =
                                                      localImage.path;
                                                },
                                              ),
                                              const Div(),
                                              ListTile(
                                                title: Text(t.bottom_sheet.photo),
                                                leading: const Icon(Icons.photo),
                                                onTap: () async {
                                                  pop();
                                                  XFile? image =
                                                      await ImagePicker()
                                                          .pickImage(
                                                    source: ImageSource.gallery,
                                                  );
                                          
                                                  if (image == null) return;
                                          
                                                  String duplicateFilePath =
                                                      (await getApplicationDocumentsDirectory())
                                                          .path;
                                          
                                                  var fileName =
                                                      image.path.split('/').last;
                                                  File localImage =
                                                      await File(image.path).copy(
                                                    '$duplicateFilePath/$fileName',
                                                  );
                                                  carPicturePath.value =
                                                      localImage.path;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                label: Text(
                                  t.park_dialog.photo.title,
                                ),
                                icon: const Icon(Icons.add_a_photo_outlined),
                              ),
                            ],
                          ),
                        ),
                        12.h,
                        Obx(
                          () => carPicturePath.value.isEmpty
                              ? const SizedBox()
                              : Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.dialog(
                                          AlertDialog(
                                            content: GestureDetector(
                                              onTap: () {
                                                pop();
                                              },
                                              child: Image.file(
                                                File(carPicturePath.value),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                            actionsPadding: EdgeInsets.zero,
                                          ),
                                          name: 'Foto',
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: FileImage(
                                            File(carPicturePath.value),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          carPicturePath.value = '';
                                        },
                                        icon: const Icon(Icons.clear),
                                        color: Get.theme.colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  16.h,
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.dialog.abort),
              onPressed: () {
                pop();
              },
            ),
            OutlinedButton(
              child: Text(t.dialog.save),
              onPressed: () async {
                pop();
                woAuto.addCarPark(
                  newPosition,
                  extra: textController.text,
                  newName: newNameController.value.text,
                  photoPath: carPicturePath.value,
                );

                if (woAuto.mapController.value == null) {
                  return;
                }
                await woAuto.mapController.value!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: newPosition,
                      zoom: CAM_ZOOM,
                    ),
                  ),
                );

                Get.snackbar(
                  t.snackbar.locked.title,
                  t.snackbar.locked.subtitle,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Get.theme.colorScheme.primary,
                  duration: const Duration(seconds: 15),
                  mainButton: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(t.snackbar.locked.action),
                  ),
                  backgroundColor: Get.theme.colorScheme.primaryContainer,
                );
              },
            ),
          ],
        ),
      ),
      name: 'Parkplatz speichern',
    );
  }

  Marker makeCarMarker(CarPark park) {
    return Marker(
      markerId: MarkerId(park.uuid),
      position: park.latLng,
      consumeTapEvents: true,
      onTap: () async {
        woAuto.mapController.value?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: park.latLng,
              zoom: CAM_ZOOM,
            ),
          ),
        );

        woAuto.tempMarkers.clear();
        woAuto.currentSelectedPosition.value = park.latLng;
        woAuto.currentSelectedCarPark.value = park;
      },
      icon: park.mine
          ? BitmapDescriptor.defaultMarker
          : BitmapDescriptor.defaultMarkerWithHue(uuidToHue(park.uuid)),
    );
  }

  void showCarParkDialog(CarPark park) {
    var datum = park.updatedAt == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(park.updatedAt!);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(park.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (park.photoPath != null && park.photoPath!.isNotEmpty)
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      content: GestureDetector(
                        onTap: () {
                          pop();
                        },
                        child: Image.file(
                          File(park.photoPath!),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      actionsPadding: EdgeInsets.zero,
                    ),
                    name: 'Foto',
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(
                      File(park.photoPath!),
                    ),
                  ),
                ),
              ),
            5.h,
            !park.mine
                ? Text(
                    t.marker_dialog.shared.content(
                      address: park.adresse ??
                          'Adresse konnte nicht gefunden werden.',
                    ),
                  )
                : Text(
                    t.marker_dialog.mine.content(
                      formattedDate: formatDateTimeAndTime(datum),
                      address: park.adresse ??
                          'Adresse konnte nicht gefunden werden.',
                      description: park.description ?? '',
                    ),
                  ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
            ),
            onPressed: () {
              carParkings.removeWhere((element) => element.uuid == park.uuid);
              carParkings.refresh();

              WoAutoServer woAutoServer = Get.find();
              woAutoServer.deleteUserParking(park.uuid);

              woAuto.save();
              Get.back();
            },
            child: Text(t.marker_dialog.action_1),
          ),
        ],
      ),
      name: 'Parkplatz Info',
    );
  }

  Future<void> addCarPark(
    LatLng newPosition, {
    String extra = '',
    String? newName,
    String? photoPath,
  }) async {
    var adresse = await getAddress(newPosition);
    String name;
    switch (newName) {
      case null:
        name = woAuto.subText.value;
      case '':
        name = woAuto.subText.value;
      default:
        name = newName;
    }

    if (carParkings.any((element) => element.name == name && element.mine)) {
      // Update
      logMessage('Update Car Park');
      var carPark = carParkings
          .firstWhere((element) => element.name == name && element.mine);
      carPark.latitude = newPosition.latitude;
      carPark.longitude = newPosition.longitude;
      carPark.adresse = adresse;
      carPark.updatedAt = DateTime.now().millisecondsSinceEpoch;
      carPark.description = extra;
      carPark.photoPath = photoPath;
      woAuto.carParkingHistory.add(carPark);
      woAuto.carParkings.refresh();
      woAuto.save();

      // safe to WoAutoServer
      WoAutoServer woAutoServer = Get.find();
      woAutoServer.addUserParkingLocation(carPark);

      return;
    }
    logMessage('Add first Car Park');
    Uuid uuid = const Uuid();

    var carPark = CarPark(
      uuid: uuid.v4(),
      name: name,
      mine: true,
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      adresse: adresse,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      description: extra,
      photoPath: photoPath,
    );

    woAuto.carParkings.add(carPark);
    woAuto.carParkingHistory.add(carPark);
    woAuto.carParkings.refresh();
    woAuto.save();

    // safe to WoAutoServer
    WoAutoServer woAutoServer = Get.find();
    woAutoServer.addUserParkingLocation(carPark);
  }

  Future<void> addFriendPosition({
    required LatLng newPosition,
    required String uuid,
    String? newName,
  }) async {
    var adresse = await getAddress(newPosition);
    var name = newName ?? t.constants.default_shared_title;

    if (friendPositions
        .any((element) => element.uuid == uuid && !element.mine)) {
      // Update
      logMessage('Update Friend Position');
      var carPark = friendPositions
          .firstWhere((element) => element.uuid == uuid && !element.mine);
      carPark.latitude = newPosition.latitude;
      carPark.longitude = newPosition.longitude;
      carPark.adresse = adresse;
      carPark.name = name;
      carPark.updatedAt = DateTime.now().millisecondsSinceEpoch;
      woAuto.friendPositions.refresh();

      woAuto.save();
      return;
    }
    logMessage('Add Friend Position');
    var carPark = CarPark(
      uuid: uuid,
      name: name,
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      adresse: adresse,
      mine: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    woAuto.friendPositions.add(carPark);
    woAuto.friendPositions.refresh();
    woAuto.save();
  }

  Future<void> deleteFriendPosition({
    required String uuid,
  }) async {
    var idx = friendPositions
        .indexOf((element) => element.uuid == uuid && !element.mine);

    if (idx == -1) {
      return;
    }

    friendPositions.removeAt(idx);
    friendPositions.refresh();
    save();
  }

  Future<void> addFriendCarPosition({
    required LatLng newPosition,
    required String uuid,
    String? newName,
  }) async {
    var adresse = await getAddress(newPosition);
    var name = newName ?? t.constants.default_shared_title;

    if (friendCarPositions
        .any((element) => element.uuid == uuid && !element.mine)) {
      // Update
      logMessage('Update Friend Car Position');
      var carPark = friendCarPositions
          .firstWhere((element) => element.uuid == uuid && !element.mine);
      carPark.latitude = newPosition.latitude;
      carPark.longitude = newPosition.longitude;
      carPark.adresse = adresse;
      carPark.name = name;
      carPark.updatedAt = DateTime.now().millisecondsSinceEpoch;
      woAuto.friendCarPositions.refresh();

      woAuto.save();
      return;
    }
    logMessage('Add Friend Car Position');
    var carPark = CarPark(
      uuid: uuid,
      name: name,
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      adresse: adresse,
      mine: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    woAuto.friendCarPositions.add(carPark);
    woAuto.friendCarPositions.refresh();
    woAuto.save();
  }

  Future<void> deleteFriendCarPosition({
    required String uuid,
  }) async {
    var idx = friendCarPositions.indexOf((element) => element.uuid == uuid);

    if (idx == -1) {
      return;
    }

    friendCarPositions.removeAt(idx);
    friendCarPositions.refresh();
    save();
  }

  String? getMapStyle() {
    if (woAuto.themeMode.value != 0) {
      return woAuto.themeMode.value == 2 ? darkMapStyle : lightMapStyle;
    }

    return Get.theme.brightness == Brightness.dark
        ? darkMapStyle
        : lightMapStyle;
  }

  Future<void> fetchPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.version;
      appBuildNumber.value = packageInfo.buildNumber;
    } catch (e) {
      logMessage(e.toString(), tag: 'Error @ WoAuto.fetchPackageInfo');
    }
  }

  String getDistanceString(LatLng position) {
    var myLat = currentPosition.value.target.latitude;
    var myLng = currentPosition.value.target.longitude;
    var distanceMeters = calculateDistance(
      myLat,
      myLng,
      position.latitude,
      position.longitude,
    );

    if (distanceMeters > 1000) {
      distanceMeters /= 1000;
      return '${distanceMeters.toStringAsFixed(2)} km';
    }

    return '${distanceMeters.toStringAsFixed(2)} m';
  }

  double getDistance(LatLng pos) {
    var myLat = currentPosition.value.target.latitude;
    var myLng = currentPosition.value.target.longitude;
    return calculateDistance(
      myLat,
      myLng,
      pos.latitude,
      pos.longitude,
    ).toPrecision(1);
  }

  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) =>
      Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
}
