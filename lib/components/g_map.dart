import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  final mapLoading = true.obs;
  final WoAutoServer woAutoServer = Get.find();

  late Timer timer;

  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    timer.cancel();
    super.dispose();
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
                    woAuto.tempMarkers.removeWhere(
                      (element) => element.markerId.value == 'temp',
                    );
                  }
                  woAuto.tempMarkers.add(
                    Marker(
                      markerId: const MarkerId('temp'),
                      position: pos,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange,
                      ),
                      onTap: () {
                        woAuto.tempMarkers.removeWhere(
                          (element) => element.markerId.value == 'temp',
                        );
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
                        10.h,
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
