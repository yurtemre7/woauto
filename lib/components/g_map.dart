import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:woauto/classes/wa_position.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/utilities.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> with WidgetsBindingObserver {
  final mapLoading = true.obs;
  final WoAutoServer woAutoServer = Get.find();

  late Timer timer;

  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadPositionData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    positionStream?.cancel();
    timer.cancel();
    super.dispose();
  }

  loadPositionData() async {
    mapLoading.value = true;

    var location = loc.Location();

    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Get.dialog(
          AlertDialog(
            title: Text(t.dialog.maps.location_denied.title),
            content: Text(t.dialog.maps.location_denied.subtitle),
            actions: [
              TextButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                  pop();
                },
                child: Text(t.dialog.open_settings),
              ),
            ],
          ),
          name: 'Standort Berechtigung',
        );

        return loadPositionData();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Get.dialog(
        AlertDialog(
          title: Text(t.dialog.maps.location_denied.title),
          content: Text(t.dialog.maps.location_denied.subtitle),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
                pop();
              },
              child: Text(t.dialog.open_settings),
            ),
          ],
        ),
        name: 'Standort Berechtigung',
      );
      return loadPositionData();
    }

    late LocationSettings locationSettings;

    if (isAndroid()) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        forceLocationManager: true,
        intervalDuration: 500.milliseconds,
      );
    } else if (isIOS()) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        activityType: ActivityType.automotiveNavigation,
        pauseLocationUpdatesAutomatically: true,
        allowBackgroundLocationUpdates: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      );
    }

    timer = Timer.periodic(10.seconds, (t) async {
      var currentPosition = woAuto.currentPosition.value.target;

      if (woAutoServer.shareMyLastLiveLocation.value) {
        woAutoServer.setUserLocation(
          LatLng(
            currentPosition.latitude,
            currentPosition.longitude,
          ),
        );
      }

      // share cars

      if (woAutoServer.shareMyParkings.value) {
        var carParkingList = woAuto.carParkings.toList();
        var myParking = carParkingList.where((element) => element.mine);

        for (var park in myParking) {
          // TODO
        }
      }
    });

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      if (!mounted || position == null) {
        return;
      }
      woAuto.currentPosition.value = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: CAM_ZOOM,
      );

      if (woAuto.drivingMode.value) {
        if (woAuto.mapController.value != null) {
          woAuto.currentPosition.value = CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: CAM_ZOOM,
            bearing: position.heading,
          );
          woAuto.mapController.value!.animateCamera(
            CameraUpdate.newCameraPosition(
              woAuto.currentPosition.value,
            ),
          );
        }
      }

      woAuto.currentVelocity.value = position.speed;

      if (!woAuto.drivingMode.value && woAuto.askForDrivingMode.value) {
        if (kDebugMode) return;
        // show dialog to ask the user if he wants to switch to driving mode, IF his velocity is > woAuto.drivingModeDetectionSpeed.value
        var kmh = ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6);

        if (kmh > woAuto.drivingModeDetectionSpeed.value) {
          if (woAuto.currentIndex.value == 0) {
            woAuto.askForDrivingMode.value = false;
            var result = await Get.dialog<bool?>(
              AlertDialog(
                title: Text(t.dialog.maps.driving_mode.title),
                content: Text(
                  t.dialog.maps.driving_mode.subtitle,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      pop(result: false);
                    },
                    child: Text(t.dialog.no),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      pop(result: true);
                    },
                    child: Text(t.dialog.yes),
                  ),
                ],
              ),
              name: 'Fahrmodus',
            );
            if (result != null && result) {
              woAuto.drivingMode.value = true;
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: Obx(
        () {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: woAuto.carMarkers.isEmpty
                    ? woAuto.currentPosition.value
                    : CameraPosition(
                        target: woAuto.carMarkers.elementAt(0).position,
                        zoom: 16,
                      ),
                trafficEnabled: woAuto.showTraffic.value,
                style: woAuto.getMapStyle(),
                mapToolbarEnabled: false,
                onMapCreated: _onMapCreated,
                compassEnabled: false,
                mapType: woAuto.mapType.value,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                padding: const EdgeInsets.only(left: 10, right: 10),
                markers: woAuto.carMarkers.toSet()
                  ..addAll(woAuto.tempMarkers.toSet())
                  ..addAll(woAuto.friendPositionMarkers.toSet())
                  ..addAll(woAuto.friendCarMarkers.toSet()),
                onTap: (pos) {
                  if (woAuto.tempMarkers.isNotEmpty) {
                    woAuto.tempMarkers.removeWhere((element) => element.markerId.value == 'temp');
                  }
                  woAuto.tempMarkers.add(
                    Marker(
                      markerId: const MarkerId('temp'),
                      position: pos,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                      onTap: () {
                        woAuto.tempMarkers
                            .removeWhere((element) => element.markerId.value == 'temp');
                        woAuto.currentSelectedPosition.value = null;
                        woAuto.currentSelectedCarPark.value = null;
                      },
                    ),
                  );
                  woAuto.currentSelectedPosition.value = pos;
                  woAuto.currentSelectedCarPark.value = null;
                },
              ),
              if (mapLoading.value)
                Container(
                  color: getBackgroundColor(context),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        Text(
                          t.maps.loading,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    woAuto.mapController.value = controller;
    await loadMapStyles();
    await Future.delayed(2.seconds);
    mapLoading.value = false;

    Position? locationData;
    try {
      locationData = await Geolocator.getCurrentPosition();
    } catch (e) {
      return;
    }

    woAuto.currentPosition.value = CameraPosition(
      target: LatLng(
        locationData.latitude,
        locationData.longitude,
      ),
      zoom: CAM_ZOOM,
    );
    if (woAuto.mapController.value != null) {
      woAuto.mapController.value!.animateCamera(
        CameraUpdate.newCameraPosition(
          woAuto.currentPosition.value,
        ),
      );
    }
  }
}
