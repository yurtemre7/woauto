import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> with WidgetsBindingObserver {
  final mapLoading = true.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadPositionData();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      if (woAuto.mapController.value == null) return;
      woAuto.setMapStyle();
    });
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  loadPositionData() async {
    mapLoading.value = true;
    bool hasReadPermission = woAuto.sp.getBool('hasReadPermission') ?? false;
    bool? skip;
    if (!hasReadPermission) {
      mapLoading.value = false;
      await Future.delayed(
        0.seconds,
        () async {
          skip = await Get.dialog<bool>(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Zugriff auf Standortdaten'),
              content: const Text(
                'Damit WoAuto deine jetzige Position und andere Positionen korrekt errechnen kann, brauchen wir deine Standortdaten während der Appnutzung.\n\nBitte erlaube WoAuto den Zugriff auf deine Standortdaten.',
              ),
              actions: [
                TextButton(
                  onPressed: () => pop(result: true),
                  child: const Text('Abbrechen'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    woAuto.sp.setBool('hasReadPermission', true);
                    pop(result: false);
                    if (mounted) {
                      setState(() {});
                    }
                    LocationData? locationData;
                    try {
                      locationData = await Location().getLocation();
                    } catch (e) {
                      return;
                    }

                    woAuto.currentPosition.value = CameraPosition(
                      target: LatLng(
                        locationData.latitude ?? 0,
                        locationData.longitude ?? 0,
                      ),
                      zoom: 18,
                    );

                    if (woAuto.mapController.value != null) {
                      woAuto.mapController.value!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          woAuto.currentPosition.value,
                        ),
                      );
                    }
                  },
                  child: const Text('Erlauben'),
                ),
              ],
            ),
            barrierDismissible: false,
          );
        },
      );
    }

    if (skip != null && skip == true) {
      mapLoading.value = false;
      return;
    }

    Location location = Location();

    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) async {
      woAuto.currentPosition.value = CameraPosition(
        target: LatLng(
          currentLocation.latitude ?? 0,
          currentLocation.longitude ?? 0,
        ),
        zoom: 18,
      );
      var tempParkList = woAuto.parkingList.toList();
      for (int i = 0; i < tempParkList.length; i++) {
        var park = tempParkList[i];
        tempParkList[i]['distance'] = woAuto.getDistance(LatLng(park['lat'], park['long']));
      }
      woAuto.parkingList.value = tempParkList;
      tempParkList = woAuto.pinList.toList();
      for (int i = 0; i < tempParkList.length; i++) {
        var park = tempParkList[i];
        tempParkList[i]['distance'] = woAuto.getDistance(LatLng(park['lat'], park['long']));
      }
      woAuto.pinList.value = tempParkList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: woAuto.currentPosition.value,
              onMapCreated: (GoogleMapController controller) async {
                woAuto.mapController.value = controller;
                await loadMapStyles();
                await Future.delayed(2.seconds);
                mapLoading.value = false;
                bool hasReadPermission = woAuto.sp.getBool('hasReadPermission') ?? false;
                if (!hasReadPermission) {
                  return;
                }
                LocationData? locationData;
                try {
                  locationData = await Location().getLocation();
                } catch (e) {
                  return;
                }

                woAuto.currentPosition.value = CameraPosition(
                  target: LatLng(
                    locationData.latitude ?? 0,
                    locationData.longitude ?? 0,
                  ),
                  zoom: 18,
                );
                if (woAuto.mapController.value != null) {
                  woAuto.mapController.value!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      woAuto.currentPosition.value,
                    ),
                  );
                }
              },
              mapType: woAuto.mapType.value,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: woAuto.markers.toSet(),
              onTap: (LatLng newPosition) {
                if (kDebugMode) {
                  woAuto.printWoAuto();
                }
                if (woAuto.snappingSheetController.value.isAttached) {
                  var snapPos = woAuto.snappingSheetController.value.currentSnappingPosition;
                  var offset = snapPos.grabbingContentOffset;
                  if (offset < 0) {
                    woAuto.snappingSheetController.value.snapToPosition(
                      SnappingPosition.factor(
                        positionFactor: 0.0,
                        snappingCurve: Curves.easeOutExpo,
                        snappingDuration: 1300.milliseconds,
                        grabbingContentOffset: GrabbingContentOffset.top,
                      ),
                    );
                    return;
                  }
                }
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text('Neuer Parkplatz'),
                    content: const Text('Neuen Parkplatz speichern?'),
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
                          woAuto.addMarker(newPosition);

                          pop();
                          GoogleMapController controller = woAuto.mapController.value!;
                          await controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: newPosition, zoom: 18),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            if (mapLoading.value)
              Container(
                color: getBackgroundColor(context),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
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
}
