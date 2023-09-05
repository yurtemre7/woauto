import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/timezone.dart' as tz;

/// The WoAuto GetXController class
class WoAuto extends GetxController {
  final currentPosition = const CameraPosition(
    target: LatLng(
      37.42796133580664,
      -122.085749655962,
    ),
    zoom: 16,
  ).obs;

  final carParkings = <CarPark>[].obs;
  RxList<Marker> get carMarkers => carParkings.map((park) => makeCarMarker(park)).toList().obs;
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
  final mapType = MapType.normal.obs;
  final showTraffic = false.obs;
  final timePuffer = 10.obs;
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
  final dayColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
  ).obs;
  final nightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ).obs;

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
      'carParkings': carParkings.map((e) => e.toJson()).toList(),
      'carParkHistory': carParkingHistory.map((e) => e.toJson()).toList(),
      'welcome': welcome.value,
      'timePuffer': timePuffer.value,
      'drivingModeDetectionSpeed': drivingModeDetectionSpeed.value,
    });
  }

  // from json string
  static fromJson(String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    WoAuto woAuto = WoAuto(await SharedPreferences.getInstance());

    woAuto.welcome.value = jsonMap['welcome'] ?? true;
    woAuto.timePuffer.value = jsonMap['timePuffer'] ?? 10;
    woAuto.drivingModeDetectionSpeed.value = jsonMap['drivingModeDetectionSpeed'] ?? 20;

    var carParkings = jsonMap['carParkings'] ?? [];
    for (int i = 0; i < carParkings.length; i++) {
      woAuto.carParkings.add(CarPark.fromJson(carParkings[i]));
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

    woAuto.subText.value = jsonMap['subText'] ?? 'Mein Auto';
    woAuto.kennzeichen.value = jsonMap['kennzeichen'] ?? '';
    woAuto.kilometerStand.value = jsonMap['kilometerStand'] ?? '';
    woAuto.tuvUntil.value = DateTime.parse(jsonMap['tuvUntil'] ?? DateTime.now().toIso8601String());
    woAuto.carPicture.value = jsonMap['carPicture'] ?? '';
    woAuto.carBaujahr.value = jsonMap['carPictureDate'] ?? DateTime.now().year.toString();
    // settings
    woAuto.themeMode.value = jsonMap['themeMode'] ?? 0;

    return woAuto;
  }

  // save to local storage
  save() async {
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
  printWoAuto() {
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
    logMessage('Time Puffer: $timePuffer');
    logMessage('Driving Mode Detection Speed: $drivingModeDetectionSpeed');

    logMessage('---' * 15);
  }

  /// Resets the WoAuto provider
  reset() async {
    subText.value = 'Mein Auto';
    kennzeichen.value = '';
    kilometerStand.value = '';
    tuvUntil.value = DateTime.now();
    carPicture.value = '';
    carBaujahr.value = DateTime.now().year.toString();

    themeMode.value = 0;
    timePuffer.value = 10;
    drivingModeDetectionSpeed.value = 20;

    carParkings.clear();
    carParkingHistory.clear();
    tempMarkers.clear();

    sp.clear();
    welcome.value = true;
    currentIndex.value = 0;

    await woAuto.save();
  }

  Future<void> onNewParking(LatLng newPosition) async {
    if (kDebugMode) {
      woAuto.printWoAuto();
    }
    var textController = TextEditingController();
    var newNameController = TextEditingController(text: woAuto.subText.value);
    var tillTime = Rxn<TimeOfDay>();
    var carPicturePath = ''.obs;

    Get.dialog(
      GestureDetector(
        onTap: () => FocusScope.of(Get.context!).unfocus(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Neuer Parkplatz'),
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  title: Text('Neuen Parkplatz speichern?'),
                ),
                ExpandablePanel(
                  header: const ListTile(
                    title: Text('Zusätzliche Info zum Parkplatz'),
                  ),
                  collapsed: const SizedBox(),
                  expanded: Column(
                    children: [
                      ListTile(
                        title: TextField(
                          controller: newNameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'z.B. Mein Auto',
                            isDense: true,
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              onPressed: () => newNameController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: 'Info',
                            hintText: 'z.B. Parkdeck 2',
                          ),
                        ),
                      ),
                      if (isAndroid()) ...[
                        16.h,
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Obx(
                              () => ElevatedButton(
                                onPressed: () async {
                                  tillTime.value = await showTimePicker(
                                    context: Get.context!,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                    helpText: 'Parkticket läuft ab um',
                                    confirmText: 'Speichern',
                                    cancelText: 'Abbrechen',
                                  );
                                },
                                child: Text(
                                  'Parkticket hinzufügen${tillTime.value == null ? '' : ' (${tillTime.value!.hour.toString().padLeft(2, '0')}:${tillTime.value!.minute.toString().padLeft(2, '0')})'}',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text('Parkticket'),
                                    content: const Text(
                                      'Wenn du ein Parkticket hast, kannst du hier die Uhrzeit angeben, bis zu der das Ticket gültig ist. '
                                      'Dann erstellt die App dir einen Timer, der dich 10 Minuten vor Ende des Tickets benachrichtigt.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                  name: 'Info Parkticket',
                                );
                              },
                              icon: const Icon(Icons.question_mark_outlined),
                            ),
                          ],
                        ),
                      ],
                      ElevatedButton(
                        onPressed: () async {
                          Get.bottomSheet(
                            Card(
                              color: Get.theme.colorScheme.background,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text('Foto aufnehmen'),
                                      leading: const Icon(Icons.camera_alt),
                                      onTap: () async {
                                        pop();
                                        XFile? image = await ImagePicker()
                                            .pickImage(source: ImageSource.camera);

                                        if (image == null) return;

                                        String duplicateFilePath =
                                            (await getApplicationDocumentsDirectory()).path;

                                        var fileName = image.path.split('/').last;
                                        File localImage = await File(image.path)
                                            .copy('$duplicateFilePath/$fileName');
                                        carPicturePath.value = localImage.path;
                                      },
                                    ),
                                    const Div(),
                                    ListTile(
                                      title: const Text('Foto auswählen'),
                                      leading: const Icon(Icons.photo),
                                      onTap: () async {
                                        pop();
                                        XFile? image = await ImagePicker()
                                            .pickImage(source: ImageSource.gallery);

                                        if (image == null) return;

                                        String duplicateFilePath =
                                            (await getApplicationDocumentsDirectory()).path;

                                        var fileName = image.path.split('/').last;
                                        File localImage = await File(image.path)
                                            .copy('$duplicateFilePath/$fileName');
                                        carPicturePath.value = localImage.path;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Foto hinzufügen',
                        ),
                      ),
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
          actions: <Widget>[
            TextButton(
              child: const Text('ABBRECHEN'),
              onPressed: () {
                pop();
              },
            ),
            ElevatedButton(
              child: const Text('SPEICHERN'),
              onPressed: () async {
                woAuto.addCarPark(
                  newPosition,
                  extra: textController.text,
                  newName: newNameController.text,
                  photoPath: carPicturePath.value,
                );

                woAuto.addParkticketNotification(tillTime.value);

                pop();
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
                  'Hast du dein Auto abgeschlossen?',
                  'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.',
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Get.theme.colorScheme.primary,
                  duration: const Duration(seconds: 15),
                  mainButton: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Ja, habe ich.'),
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
        woAuto.showCarParkDialog(park);
      },
      icon: park.mine
          ? BitmapDescriptor.defaultMarker
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
  }

  showCarParkDialog(CarPark park) {
    var datum = park.createdAt == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(park.createdAt!);
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
                    'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${park.adresse ?? 'Adresse konnte nicht gefunden werden.'}.')
                : Text(
                    'Du hast ${formatDateTimeAndTime(datum)}.\n\nDein Auto steht an folgender Adresse:\n${park.adresse ?? 'Adresse konnte nicht gefunden werden.'}.\n${park.description}',
                  ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
            ),
            onPressed: () {
              WoAutoServer woAutoServer = Get.find();
              if (park.sharing) {
                woAutoServer.deleteLocationAccount(park: park);
              }
              carParkings.removeWhere((element) => element.uuid == park.uuid);
              carParkings.refresh();

              flutterLocalNotificationsPlugin.cancelAll();
              woAuto.save();
              Get.back();
            },
            child: const Text('Parkplatz löschen'),
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
    var name = newName ?? woAuto.subText.value;

    if (carParkings.any((element) => element.name == name && element.mine)) {
      // Update
      logMessage('Update Car Park');
      var carPark = carParkings.firstWhere((element) => element.name == name && element.mine);
      carPark.latitude = newPosition.latitude;
      carPark.longitude = newPosition.longitude;
      carPark.adresse = adresse;
      carPark.updatedAt = DateTime.now().millisecondsSinceEpoch;
      carPark.description = extra;
      carPark.photoPath = photoPath;
      woAuto.carParkingHistory.add(carPark);
      woAuto.carParkings.refresh();
      woAuto.save();
      if (carPark.sharing) {
        WoAutoServer woAutoServer = Get.find();
        woAutoServer.updateLocation(park: carPark);
      }

      return;
    }
    logMessage('Add first Car Park');
    Uuid uuid = const Uuid();

    var carPark = CarPark(
      uuid: uuid.v4(),
      name: name,
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
  }

  Future<void> addAnotherCarPark({
    required LatLng newPosition,
    required String uuid,
    required String view,
    String? newName,
  }) async {
    var adresse = await getAddress(newPosition);
    var name = newName ?? 'Anderes Auto';

    if (carParkings.any((element) => element.uuid == uuid && !element.mine)) {
      // Update
      logMessage('Update Another Car Park');
      var carPark = carParkings.firstWhere((element) => element.uuid == uuid && !element.mine);
      carPark.latitude = newPosition.latitude;
      carPark.longitude = newPosition.longitude;
      carPark.adresse = adresse;
      carPark.sharing = true;
      carPark.viewKey = view;
      carPark.updatedAt = DateTime.now().millisecondsSinceEpoch;
      woAuto.carParkings.refresh();

      woAuto.save();
      return;
    }
    logMessage('Add Another Car Park');
    var carPark = CarPark(
      uuid: uuid,
      name: name,
      viewKey: view,
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      adresse: adresse,
      sharing: true,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    woAuto.carParkings.add(carPark);
    woAuto.carParkings.refresh();
    woAuto.save();
  }

  Future<void> addParkticketNotification(TimeOfDay? tillTime) async {
    if (tillTime != null) {
      var differenceInSecondsFromNow = tillTime.hour * 3600 +
          tillTime.minute * 60 -
          DateTime.now().hour * 3600 -
          DateTime.now().minute * 60 -
          DateTime.now().second;

      bool? res;

      if (isIOS()) {
        res = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (isAndroid()) {
        res = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission();
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text('Benachrichtigungen'),
            content: const Text(
              'Dein Betriebssystem unterstützt keine Benachrichtigungen.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
          name: 'Info Parkticket',
        );
        return;
      }

      if (res == null || res == false) {
        Get.dialog(
          AlertDialog(
            title: const Text('Benachrichtigungen'),
            content: const Text(
              'Um dir eine Benachrichtigung zu schicken, wenn dein Parkticket abläuft, '
              'muss die App die Benachrichtigungen erlauben. '
              'Bitte erlaube die Benachrichtigungen und versuche es erneut.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
          name: 'Info Parkticket',
        );
        return;
      }

      await flutterLocalNotificationsPlugin.cancelAll();

      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetailsMAX);
      await flutterLocalNotificationsPlugin.show(
        1,
        'Auto geparkt',
        'Dein Parkticket gilt bis ${tillTime.hour.toString().padLeft(2, '0')}:${tillTime.minute.toString().padLeft(2, '0')} Uhr.',
        notificationDetails,
      );

      int minutesLeft = 0;
      int minutes = woAuto.timePuffer.value * 60;
      if (differenceInSecondsFromNow > minutes) {
        differenceInSecondsFromNow -= minutes;
        minutesLeft = woAuto.timePuffer.value;
      } else if (differenceInSecondsFromNow < 0) {
        differenceInSecondsFromNow += 86400 - minutes;
        minutesLeft = woAuto.timePuffer.value;
      } else {
        minutesLeft = differenceInSecondsFromNow ~/ 60;
      }
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Dein Parkticket läuft bald ab',
        'In ca. $minutesLeft Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: differenceInSecondsFromNow)),
        NotificationDetails(
          android: androidNotificationDetails,
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future setMapStyle({Brightness? brightness}) async {
    if (woAuto.mapController.value == null) {
      return;
    }
    var controller = woAuto.mapController.value!;
    if (brightness != null) {
      controller.setMapStyle(
        brightness == Brightness.dark ? darkMapStyle : lightMapStyle,
      );
      return;
    }
    if (woAuto.themeMode.value != 0) {
      controller.setMapStyle(
        woAuto.themeMode.value == 2 ? darkMapStyle : lightMapStyle,
      );
      return;
    }
    var theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (theme == Brightness.dark) {
      controller.setMapStyle(darkMapStyle);
    } else {
      controller.setMapStyle(lightMapStyle);
    }
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

  double getCarParkDistance(CarPark park) {
    var myLat = currentPosition.value.target.latitude;
    var myLng = currentPosition.value.target.longitude;
    return calculateDistance(
      myLat,
      myLng,
      park.latitude,
      park.longitude,
    ).toPrecision(1);
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

  double calculateDistance(lat1, lon1, lat2, lon2) =>
      Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
}
