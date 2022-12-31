import 'dart:async';

import 'package:expandable/expandable.dart';
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
    super.dispose();
  }

  loadPositionData() async {
    mapLoading.value = true;

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

      woAuto.currentVelocity.value = currentLocation.speed ?? 0;

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
                var textController = TextEditingController();
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text('Neuer Parkplatz'),
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    content: Column(
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
                          expanded: ListTile(
                            title: TextField(
                              controller: textController,
                              decoration: const InputDecoration(
                                labelText: 'Info',
                                hintText: 'z.B. Parkdeck 2',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
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
                          woAuto.addMarker(
                            newPosition,
                            extra: textController.text,
                          );

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
