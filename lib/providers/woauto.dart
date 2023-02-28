import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:woauto/classes/park.dart';
import 'package:woauto/classes/pin.dart';
import 'package:woauto/main.dart';
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

  final parkings = <Marker>{}.obs;
  final pins = <Marker>{}.obs;
  final markers = <Marker>{}.obs;

  final parkHistory = <Park>[].obs;

  final parkingList = [].obs;
  final pinList = [].obs;

  final mapController = Rxn<GoogleMapController?>();
  final snappingSheetController = Rx(SnappingSheetController());

  final welcome = true.obs;

  final appVersion = ''.obs;
  final appBuildNumber = ''.obs;
  final currentIndex = 0.obs;

  // settings
  final subText = 'Mein Auto'.obs;
  final themeMode = 0.obs;
  final mapType = MapType.normal.obs;
  final showTraffic = false.obs;

  // data
  final currentVelocity = 0.0.obs;
  final dayColorScheme = const ColorScheme.light().obs;
  final nightColorScheme = const ColorScheme.dark().obs;

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
      'themeMode': themeMode.value,
      'parkings': parkingList,
      'pins': pinList,
      'parkHistory': parkHistory,
      'welcome': welcome.value,
    });
  }

  // from json string
  static fromJson(String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    WoAuto woAuto = WoAuto(await SharedPreferences.getInstance());

    woAuto.parkingList.addAll(jsonMap['parkings'] ?? []);
    woAuto.pinList.addAll(jsonMap['pins'] ?? []);
    woAuto.welcome.value = jsonMap['welcome'] ?? true;
    List history = jsonMap['parkHistory'] ?? [];
    for (int i = 0; i < history.length; i++) {
      woAuto.parkHistory.add(Park.fromJson(history[i]));
    }

    for (int i = 0; i < woAuto.parkingList.length; i++) {
      var park = Park.fromJson(woAuto.parkingList[i]);

      woAuto.parkings.add(woAuto.makeMarker(park, 'park,$i'));
    }

    for (int i = 0; i < woAuto.pinList.length; i++) {
      var pin = Pin.fromJson(woAuto.pinList[i]);

      woAuto.pins.add(woAuto.makeMarker(pin, 'pin,$i'));
    }

    woAuto.markers.addAll(woAuto.parkings);
    woAuto.markers.addAll(woAuto.pins);

    if (woAuto.parkings.isNotEmpty) {
      var myCar = woAuto.parkings.first;
      woAuto.currentPosition.value = CameraPosition(
        target: myCar.position,
        zoom: 16,
      );
    }

    woAuto.subText.value = jsonMap['subText'] ?? 'Mein Auto';
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
    log('WoAuto', name: 'GetX Controller');
    log('Subtext: $subText', name: 'GetX Controller');
    log('Current Position: ${currentPosition.value}', name: 'GetX Controller');
    if (parkings.isNotEmpty) {
      for (var i = 0; i < parkings.length; i++) {
        log('Parkings[$i]: ${parkings.elementAt(i).position}', name: 'GetX Controller');
      }
    }
    if (pins.isNotEmpty) {
      for (var i = 0; i < pins.length; i++) {
        log('Pins[$i]: ${pins.elementAt(i).position}', name: 'GetX Controller');
      }
    }
    log('Theme Mode: $themeMode', name: 'GetX Controller');
    log('Welcome: $welcome', name: 'GetX Controller');
    log('Park History length: ${parkHistory.length}', name: 'GetX Controller');

    log('---' * 15, name: 'GetX Controller');
  }

  /// Resets the WoAuto provider
  reset() async {
    subText.value = 'Mein Auto';
    themeMode.value = 0;

    parkingList.clear();
    pinList.clear();
    parkings.clear();
    pins.clear();
    markers.clear();
    parkHistory.clear();

    sp.clear();
    welcome.value = true;
    currentIndex.value = 0;

    await woAuto.save();
  }

  makeMarker(Park park, String id) {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(
        park.latitude,
        park.longitude,
      ),
      consumeTapEvents: true,
      onTap: () async {
        woAuto.mapController.value?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                park.latitude,
                park.longitude,
              ),
              zoom: 18,
            ),
          ),
        );
        woAuto.showParkingDialog(park, id);
      },
    );
  }

  showParkingDialog(Park park, String id) {
    var datum =
        park.datum == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(park.datum!);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(park.name ?? woAuto.subText.value),
        content: park.shared ?? false
            ? Text(
                'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${park.address ?? 'Adresse konnte nicht gefunden werden.'}.')
            : Text(
                'Du hast ${formatDateTimeAndTime(datum)}.\n\nDein Auto steht an folgender Adresse:\n${park.address ?? 'Adresse konnte nicht gefunden werden.'}.\n${park.extra}',
              ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () {
              // split id by ,
              var ids = id.split(',');
              int num = int.parse(ids[1]);
              String type = ids[0];
              if (type == 'park') {
                woAuto.parkingList.removeAt(num);
                woAuto.parkings.removeWhere((Marker element) => element.markerId.value == id);
              } else {
                woAuto.pinList.removeAt(num);
                woAuto.pins.removeWhere((Marker element) => element.markerId.value == id);
              }

              markers.clear();
              markers.addAll(woAuto.pins);
              markers.addAll(woAuto.parkings);

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

  // Adds a marker to the (google) map, and clears the old ones
  Future<void> addMarker(LatLng newPosition, {String extra = '', String? newName}) async {
    // if has premium, dont clear
    woAuto.parkings.clear();
    woAuto.parkingList.clear();

    var adresse = await getAddress(newPosition);

    var park = Park(
      id: 'park,${woAuto.parkingList.length}',
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      name: newName ?? woAuto.subText.value,
      address: adresse,
      datum: DateTime.now().millisecondsSinceEpoch,
      distance: woAuto.getDistance(newPosition),
      extra: extra,
    );

    woAuto.parkHistory.add(park);
    woAuto.parkings.add(woAuto.makeMarker(park, 'park,${woAuto.parkingList.length}'));
    woAuto.parkingList.add(park.toJson());

    markers.clear();
    markers.addAll(woAuto.pins);
    markers.addAll(woAuto.parkings);
    woAuto.save();
  }

  // Adds a pin to the (google) map, and clears the old ones
  Future<void> addPin(LatLng newPosition, String title) async {
    // if has premium, dont clear
    woAuto.pins.clear();
    woAuto.pinList.clear();

    var adresse = await getAddress(newPosition);

    var pin = Pin(
      id: 'pin,${woAuto.pinList.length}',
      latitude: newPosition.latitude,
      longitude: newPosition.longitude,
      name: title,
      address: adresse,
      datum: DateTime.now().millisecondsSinceEpoch,
      distance: woAuto.getDistance(newPosition),
    );

    woAuto.pins.add(woAuto.makeMarker(pin, 'pin,${woAuto.pinList.length}'));
    woAuto.pinList.add(pin.toJson());

    markers.clear();
    markers.addAll(woAuto.pins);
    markers.addAll(woAuto.parkings);
    woAuto.save();
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
    var theme = WidgetsBinding.instance.window.platformBrightness;
    if (theme == Brightness.dark) {
      controller.setMapStyle(darkMapStyle);
    } else {
      controller.setMapStyle(lightMapStyle);
    }
  }

  fetchPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.version;
      appBuildNumber.value = packageInfo.buildNumber;
    } catch (e) {
      log(e.toString(), name: 'Error @ WoAuto.fetchPackageInfo');
    }
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
