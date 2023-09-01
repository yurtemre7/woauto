import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';
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
    logMessage('CarParkings: ${carParkings.map((e) => e.toJson())}');
    logMessage('CarMarkers length: ${carMarkers.length}');
    logMessage('CarMarkers: ${carMarkers.map((e) => e.toJson())}');
    logMessage('TempMarkers length: ${tempMarkers.length}');
    logMessage('TempMarkers: ${tempMarkers.map((e) => e.toJson())}');

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
    drivingModeDetectionSpeed.value = 10;

    carParkings.clear();
    carParkingHistory.clear();
    tempMarkers.clear();

    sp.clear();
    welcome.value = true;
    currentIndex.value = 0;

    await woAuto.save();
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
        content: park.sharing
            ? Text(
                'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${park.adresse ?? 'Adresse konnte nicht gefunden werden.'}.')
            : Text(
                'Du hast ${formatDateTimeAndTime(datum)}.\n\nDein Auto steht an folgender Adresse:\n${park.adresse ?? 'Adresse konnte nicht gefunden werden.'}.\n${park.description}',
              ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
            ),
            onPressed: () {
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
    // if has premium, dont clear
    var adresse = await getAddress(newPosition);

    Uuid uuid = const Uuid();

    var carPark = CarPark(
      uuid: uuid.v5(Uuid.NAMESPACE_URL, newName ?? woAuto.subText.value),
      name: newName ?? woAuto.subText.value,
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      adresse: adresse,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      description: extra,
      photoPath: photoPath,
    );
    // delete old car park with same uuid
    carParkings.removeWhere((element) => element.uuid == carPark.uuid);

    woAuto.carParkings.add(carPark);
    woAuto.carParkingHistory.add(carPark);
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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        math.cos((lat2 - lat1) * p) / 2 +
        math.cos(lat1 * p) * math.cos(lat2 * p) * (1 - math.cos((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a)) * 1000;
  }
}
