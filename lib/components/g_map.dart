import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:woauto/components/div.dart';
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
            title: const Text('Standort Berechtigung'),
            content: const Text(
              'Du hast die Berechtigung für den Standortzugriff verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                  pop();
                },
                child: const Text('OK'),
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
          title: const Text('Standort Berechtigung'),
          content: const Text(
            'Du hast die Berechtigung für den Standortzugriff verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
                pop();
              },
              child: const Text('OK'),
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
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: 500.milliseconds,
      );
    } else if (isIOS()) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        activityType: ActivityType.automotiveNavigation,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        allowBackgroundLocationUpdates: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 100,
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
        // show dialog to ask the user if he wants to switch to driving mode, IF his velocity is > woAuto.drivingModeDetectionSpeed.value
        var kmh = ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6);

        if (kmh > woAuto.drivingModeDetectionSpeed.value) {
          if (woAuto.currentIndex.value == 0) {
            woAuto.askForDrivingMode.value = false;
            var result = await Get.dialog<bool?>(
              AlertDialog(
                title: const Text('Driving Modus erkannt'),
                content: const Text(
                  'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      pop(result: false);
                    },
                    child: const Text('NEIN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pop(result: true);
                    },
                    child: const Text('JA'),
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
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      woAuto.showTraffic.value = !woAuto.showTraffic.value;
                      setState(() {});
                    },
                    label: Text(
                      woAuto.showTraffic.value ? 'Verkehr ausblenden' : 'Verkehr anzeigen',
                    ),
                  ),
                ),
              ),
            if (mapLoading.value)
              Container(
                color: getBackgroundColor(context),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        'Lädt Karte...',
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
        title: const Text('Standort Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Navigation starten'),
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
            Text('Abstand zum aktuellen Standort: ${woAuto.getDistance(newPosition)}m'),
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
