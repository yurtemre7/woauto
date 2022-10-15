import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woauto/main.dart';
import 'package:woauto/screens/home.dart';
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
  final latitude = RxnDouble();
  final longitude = RxnDouble();

  final positionAddress = RxnString();
  final parkings = <Marker>{}.obs;

  var mapController = Rxn<GoogleMapController?>();

  final datum = DateTime.now().obs;
  final subText = 'Mein Auto'.obs;

  final appVersion = ''.obs;
  final appBuildNumber = ''.obs;

  // settings
  final android13Theme = false.obs;
  final themeMode = 0.obs;

  late SharedPreferences sp;

  Future<SharedPreferences> get prefs async {
    return sp;
  }

  WoAuto(this.sp);

  // to json string
  String toJson() {
    return json.encode({
      'langitude': latitude.value,
      'longitude': longitude.value,
      'datum': datum.value.millisecondsSinceEpoch,
      'address': positionAddress.value,
      'subText': subText.value,
      'android13Theme': android13Theme.value,
      'themeMode': themeMode.value,
    });
  }

  // from json string
  static fromJson(String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    WoAuto woAuto = WoAuto(await SharedPreferences.getInstance());

    woAuto.latitude.value = jsonMap['langitude'];
    woAuto.longitude.value = jsonMap['longitude'];
    woAuto.datum.value = DateTime.fromMillisecondsSinceEpoch(
      jsonMap['datum'] ?? 0,
    );
    woAuto.positionAddress.value = jsonMap['address'];
    woAuto.subText.value = jsonMap['subText'] ?? 'Mein Auto';
    // settings
    woAuto.android13Theme.value = jsonMap['android13Theme'] ?? false;
    woAuto.themeMode.value = jsonMap['themeMode'] ?? 0;

    if (woAuto.longitude.value != null && woAuto.latitude.value != null) {
      woAuto.currentPosition.value = CameraPosition(
        target: LatLng(
          woAuto.latitude.value!,
          woAuto.longitude.value!,
        ),
        zoom: 16,
      );

      Marker m = Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
          woAuto.latitude.value!,
          woAuto.longitude.value!,
        ),
        consumeTapEvents: true,
        onTap: () async {
          woAuto.mapController.value?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  woAuto.latitude.value!,
                  woAuto.longitude.value!,
                ),
                zoom: 18,
              ),
            ),
          );
          Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(woAuto.subText.value),
              content: Text(
                'Du hast ${formatDateTimeAndTime(woAuto.datum.value)}.\n\nDein Auto steht an folgender Adresse: ${woAuto.positionAddress.value}',
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    woAuto.latitude.value = null;
                    woAuto.longitude.value = null;
                    woAuto.parkings.clear();
                    woAuto.positionAddress.value = '';
                    woAuto.save();
                    Get.back();
                  },
                  child: const Text('Parkplatz löschen'),
                ),
              ],
            ),
          );
        },
      );

      woAuto.parkings.clear();
      woAuto.parkings.add(m);
    }

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
    log(latitude.value.toString(), name: 'GetX Controller');
    log(longitude.value.toString(), name: 'GetX Controller');
    log(datum.value.toString(), name: 'GetX Controller');
    log(subText.value, name: 'GetX Controller');
    log(currentPosition.value.target.toString(), name: 'GetX Controller');
    if (parkings.isNotEmpty) {
      log(parkings.elementAt(0).position.toString(), name: 'GetX Controller');
    }
    log(android13Theme.value.toString(), name: 'GetX Controller');
    log(themeMode.value.toString(), name: 'GetX Controller');

    log('---' * 30, name: 'GetX Controller');
  }

  /// Resets the WoAuto provider
  reset() async {
    latitude.value = null;
    longitude.value = null;
    datum.value = DateTime.now();
    subText.value = 'Mein Auto';
    android13Theme.value = false;
    themeMode.value = 0;

    parkings.clear();
    positionAddress.value = '';
    sp.clear();
    await woAuto.save();
    Get.offAll(() => const Home());
  }

  // Adds a marker to the (google) map, and clears the old ones
  void addMarker(LatLng newPosition) {
    woAuto.parkings.clear();
    Marker m = Marker(
      markerId: const MarkerId('1'),
      position: newPosition,
      consumeTapEvents: true,
      onTap: () async {
        woAuto.mapController.value?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: newPosition,
              zoom: 18,
            ),
          ),
        );
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(subText.value),
            content: Text(
              'Du hast ${formatDateTimeAndTime(woAuto.datum.value)}.\n\nDein Auto steht an folgender Adresse: ${positionAddress.value}',
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () {
                  woAuto.latitude.value = null;
                  woAuto.longitude.value = null;
                  woAuto.parkings.clear();
                  woAuto.positionAddress.value = '';
                  woAuto.save();
                  Get.back();
                },
                child: const Text('Parkplatz löschen'),
              ),
            ],
          ),
        );
      },
    );
    woAuto.latitude.value = newPosition.latitude;
    woAuto.longitude.value = newPosition.longitude;
    woAuto.datum.value = DateTime.now();
    woAuto.save();
    woAuto.parkings.add(m);
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
}
