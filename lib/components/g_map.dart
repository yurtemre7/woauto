import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> with WidgetsBindingObserver {
  final mapLoading = true.obs;
  final WoAutoServer woAutoServer = Get.find();

  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadPositionData();
    fetchSyncLocations();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        woAuto.setMapStyle();
      });
    }
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    positionStream?.cancel();
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

  Future<void> fetchSyncLocations() async {
    logMessage('Fetching positions...');
    var carParkingList = woAuto.carParkings.toList();
    var myParking = carParkingList.where((element) => element.mine);
    var otherParking = carParkingList.where((element) => !element.mine);

    for (var element in myParking) {
      if (element.sharing) {
        woAutoServer.updateLocation(park: element);
      }
    }

    for (var element in otherParking) {
      if (element.sharing) {
        var loc = await woAutoServer.getLocation(id: element.uuid, view: element.viewKey);
        if (loc == null) {
          logMessage('Couldn\'t fetch location for ${element.name} (${element.uuid})');
          // remove from sync list
          woAuto.carParkings.removeWhere((e) => e.uuid == element.uuid);
          woAuto.carParkings.refresh();
          continue;
        }
        logMessage('Adding fetched location for ${element.name} (${element.uuid})');
        woAuto.addAnotherCarPark(
          newPosition: LatLng(double.parse(loc.lat), double.parse(loc.long)),
          uuid: element.uuid,
          view: loc.view,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
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
              // padding: const EdgeInsets.all(20),
              trafficEnabled: woAuto.showTraffic.value,
              mapToolbarEnabled: false,
              onMapCreated: _onMapCreated,
              compassEnabled: false,
              mapType: woAuto.mapType.value,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              padding: const EdgeInsets.only(left: 10, right: 10),
              markers: woAuto.carMarkers.toSet()..addAll(woAuto.tempMarkers.toSet()),
              onLongPress: _onMapLongPress,
              onTap: woAuto.onNewParking,
            ),
            if (woAuto.currentIndex.value == 0 && woAuto.drivingMode.value)
              Obx(
                () => Positioned(
                  bottom: isIOS() ? 32 : 16,
                  right: 16,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      woAuto.showTraffic.value = !woAuto.showTraffic.value;
                      setState(() {});
                    },
                    label: Text(
                      woAuto.showTraffic.value ? t.maps.traffic.hide : t.maps.traffic.show,
                    ),
                  ),
                ),
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
    );
  }

  Future<void> _onMapLongPress(LatLng newPosition) async {
    logMessage('Long Pressed at $newPosition');
    woAuto.tempMarkers.add(
      Marker(
        markerId: const MarkerId('temp'),
        position: newPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    );
    await Get.dialog(
      AlertDialog(
        title: Text(t.dialog.navigation.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(t.dialog.navigation.action_1),
              onTap: () {
                Get.back();
                MapsLauncher.launchCoordinates(
                  newPosition.latitude,
                  newPosition.longitude,
                );
              },
              leading: const Icon(Icons.directions),
            ),
            const Div(),
            Text(t.dialog.navigation.distance_info(distance: woAuto.getDistance(newPosition))),
          ],
        ),
      ),
    );
    flutterLocalNotificationsPlugin.cancelAll();
    woAuto.tempMarkers.removeWhere((element) => element.markerId.value == 'temp');
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
