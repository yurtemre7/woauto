import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:woauto/components/top_header.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
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
      if (!mounted) {
        return;
      }
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
      woAuto.parkingList.clear();
      woAuto.parkingList.assignAll(tempParkList);
      tempParkList = woAuto.pinList.toList();
      for (int i = 0; i < tempParkList.length; i++) {
        var park = tempParkList[i];
        tempParkList[i]['distance'] = woAuto.getDistance(LatLng(park['lat'], park['long']));
      }
      woAuto.pinList.clear();
      woAuto.pinList.assignAll(tempParkList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: woAuto.markers.isEmpty
                  ? woAuto.currentPosition.value
                  : CameraPosition(
                      target: woAuto.markers.elementAt(0).position,
                      zoom: 16,
                    ),
              // padding: const EdgeInsets.all(20),
              trafficEnabled: woAuto.showTraffic.value,
              mapToolbarEnabled: false,
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
              compassEnabled: false,
              mapType: woAuto.mapType.value,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              padding: const EdgeInsets.only(left: 10, right: 10),
              markers: woAuto.markers.toSet(),
              onTap: (LatLng newPosition) {
                if (kDebugMode) {
                  woAuto.printWoAuto();
                }
                if (woAuto.snappingSheetController.value.isAttached) {
                  var snapPos = woAuto.snappingSheetController.value.currentSnappingPosition;
                  var offset = snapPos.grabbingContentOffset;
                  if (offset > 0) {
                    woAuto.snappingSheetController.value.snapToPosition(
                      resetPosition,
                    );
                    return;
                  }
                }
                var textController = TextEditingController();
                var newNameController = TextEditingController(text: woAuto.subText.value);
                var tillTime = Rxn<TimeOfDay>();

                Get.dialog(
                  AlertDialog(
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
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      hintText: 'z.B. Mein Auto',
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: TextField(
                                    controller: textController,
                                    decoration: const InputDecoration(
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
                                            // show time picker of today
                                            tillTime.value = await showTimePicker(
                                              context: context,
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
                                        icon: const Icon(Icons.question_mark),
                                      ),
                                    ],
                                  ),
                                ],
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
                          woAuto.addMarker(
                            newPosition,
                            extra: textController.text,
                            newName: newNameController.text,
                          );

                          if (tillTime.value != null) {
                            var differenceInSecondsFromNow = tillTime.value!.hour * 3600 +
                                tillTime.value!.minute * 60 -
                                DateTime.now().hour * 3600 -
                                DateTime.now().minute * 60 -
                                DateTime.now().second;
                            var title = 'Deine Restparkzeit';

                            // if difference bigger then 600 seconds (10 minutes)
                            // if (differenceInSecondsFromNow > 600) {
                            //   differenceInSecondsFromNow -= 600;
                            //   title = 'Parkticket noch 10 Minuten übrig.';
                            // } else if (differenceInSecondsFromNow < 0) {
                            //   differenceInSecondsFromNow += 86400 - 600;
                            //   title = 'Parkticket noch 10 Minuten übrig.';
                            // } else {
                            //   title = 'Parkticket ist abgelaufen.';
                            // }

                            FlutterAlarmClock.createTimer(
                              differenceInSecondsFromNow,
                              title: title,
                            );
                          }

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
                  name: 'Parkplatz speichern',
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
