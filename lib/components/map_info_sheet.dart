import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class MapInfoSheet extends StatefulWidget {
  const MapInfoSheet({super.key});

  @override
  State<MapInfoSheet> createState() => _MapInfoSheetState();
}

class _MapInfoSheetState extends State<MapInfoSheet> {
  SnappingSheetController snappingSheetController = SnappingSheetController();
  ScrollController scrollController = ScrollController();

  bool up = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var snapPos = snappingSheetController.currentSnappingPosition;
        var offset = snapPos.grabbingContentOffset;
        if (offset < 0) {
          snappingSheetController.snapToPosition(
            SnappingPosition.factor(
              positionFactor: 0.0,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: 1300.milliseconds,
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
          );
          return false;
        }

        return await Get.dialog(
          AlertDialog(
            title: const Text('App verlassen'),
            content: const Text('Möchtest du die App verlassen?'),
            actions: [
              TextButton(
                child: const Text('ABBRECHEN'),
                onPressed: () => Get.back(result: false),
              ),
              ElevatedButton(
                child: const Text('VERLASSEN'),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: SnappingSheet(
        controller: snappingSheetController,
        snappingPositions: [
          SnappingPosition.factor(
            positionFactor: 0.0,
            snappingCurve: Curves.easeOutExpo,
            snappingDuration: 1300.milliseconds,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          SnappingPosition.factor(
            positionFactor: 0.6,
            snappingCurve: Curves.bounceOut,
            snappingDuration: 1300.milliseconds,
            grabbingContentOffset: GrabbingContentOffset.bottom,
          ),
        ],
        lockOverflowDrag: true,
        grabbingHeight: minHeightSheet,
        grabbing: Container(
          margin: const EdgeInsets.only(
            left: 5,
            right: 5,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      var snapPos =
                          snappingSheetController.currentSnappingPosition;
                      var offset = snapPos.grabbingContentOffset;

                      scrollController.animateTo(
                        0,
                        duration: 250.milliseconds,
                        curve: Curves.linear,
                      );

                      if (offset > 0) {
                        snappingSheetController.snapToPosition(
                          SnappingPosition.factor(
                            positionFactor: 0.6,
                            snappingCurve: Curves.bounceOut,
                            snappingDuration: 1300.milliseconds,
                            grabbingContentOffset: GrabbingContentOffset.bottom,
                          ),
                        );
                        return;
                      }
                      snappingSheetController.snapToPosition(
                        SnappingPosition.factor(
                          positionFactor: 0.0,
                          snappingCurve: Curves.easeOutExpo,
                          snappingDuration: 1300.milliseconds,
                          grabbingContentOffset: GrabbingContentOffset.top,
                        ),
                      );
                    },
                    child: Container(
                      width: 110,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  child: SizedBox(
                    height: 50,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        if (woAuto.parkings.isNotEmpty) {
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
                                    woAuto.addMarker(
                                      woAuto.currentPosition.value.target,
                                    );
                                    getAddress(
                                            woAuto.currentPosition.value.target)
                                        .then((value) {
                                      woAuto.positionAddress.value = value;
                                      woAuto.save();
                                    });

                                    if (woAuto.mapController.value == null) {
                                      return;
                                    }

                                    var snapPos = snappingSheetController
                                        .currentSnappingPosition;
                                    var offset = snapPos.grabbingContentOffset;
                                    if (offset < 0) {
                                      snappingSheetController.snapToPosition(
                                        SnappingPosition.factor(
                                          positionFactor: 0.0,
                                          snappingCurve: Curves.easeOutExpo,
                                          snappingDuration: 1300.milliseconds,
                                          grabbingContentOffset:
                                              GrabbingContentOffset.top,
                                        ),
                                      );
                                    }

                                    woAuto.mapController.value!.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: woAuto
                                              .currentPosition.value.target,
                                          zoom: 18,
                                        ),
                                      ),
                                    );

                                    pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          woAuto.addMarker(
                            woAuto.currentPosition.value.target,
                          );
                          getAddress(woAuto.currentPosition.value.target)
                              .then((value) {
                            woAuto.positionAddress.value = value;
                            woAuto.save();
                          });
                          var snapPos =
                              snappingSheetController.currentSnappingPosition;
                          var offset = snapPos.grabbingContentOffset;
                          if (offset < 0) {
                            snappingSheetController.snapToPosition(
                              SnappingPosition.factor(
                                positionFactor: 0.0,
                                snappingCurve: Curves.easeOutExpo,
                                snappingDuration: 1300.milliseconds,
                                grabbingContentOffset:
                                    GrabbingContentOffset.top,
                              ),
                            );
                          }
                          woAuto.mapController.value!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: woAuto.currentPosition.value.target,
                                zoom: 18,
                              ),
                            ),
                          );
                        }
                      },
                      label: const Text(
                        'Parkplatz speichern',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.local_parking_rounded),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        sheetBelow: SnappingSheetContent(
          childScrollController: scrollController,
          draggable: true,
          child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14.0, top: 10),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const Text(
                          'Aktionen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Standort Teilen'),
                          onPressed: () {
                            // share parking location to whatsapp, telegram etc.
                            if (woAuto.parkings.isEmpty) {
                              // show snackbar error
                              Get.snackbar(
                                'Fehler',
                                'Kein Parkplatz gespeichert',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                duration: 1.seconds,
                              );
                              return;
                            }
                            LatLng myCar =
                                woAuto.parkings.elementAt(0).position;
                            String link =
                                'https://www.google.com/maps?q=${myCar.latitude},${myCar.longitude}';

                            Share.share('Ich habe hier geparkt: $link');
                          },
                        ),

                        TextButton.icon(
                          onPressed: () async {
                            GoogleMapController controller =
                                woAuto.mapController.value!;
                            await controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                woAuto.currentPosition.value,
                              ),
                            );
                          },
                          icon: const Icon(Icons.location_on_outlined),
                          label: const Text('Gehe zu meinem Standort'),
                        ),

                        // infos about your parking spot
                        Obx(
                          () {
                            String? address = woAuto.positionAddress.value;
                            return Visibility(
                              visible: woAuto.parkings.isNotEmpty,
                              child: Column(
                                children: [
                                  TextButton.icon(
                                    onPressed: () async {
                                      GoogleMapController controller =
                                          woAuto.mapController.value!;
                                      await controller.animateCamera(
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
                                    },
                                    icon: const Icon(
                                      Icons.local_parking_rounded,
                                    ),
                                    label:
                                        const Text('Gehe zu meinem Parkplatz'),
                                  ),
                                  const Div(),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Information',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${formatDateTimeAndTime(woAuto.datum.value)}:',
                                  ),
                                  const SizedBox(height: 5),
                                  if (address == null)
                                    const Text(
                                      'Ein Fehler beim Herausfinden der Parkadresse ist aufgetreten.',
                                    ),
                                  if (address != null && address.isEmpty)
                                    const Text(
                                      'Keine Adresse gefunden.',
                                    ),
                                  if (address != null && address.isNotEmpty)
                                    TextButton.icon(
                                      label: Text(
                                        address.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      icon: const Icon(Icons.map),
                                      onPressed: () async {
                                        if (woAuto.parkings.isEmpty) {
                                          // show snackbar error
                                          Get.snackbar(
                                            'Fehler',
                                            'Kein Parkplatz gespeichert',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            borderRadius: 10,
                                            margin: const EdgeInsets.all(10),
                                            duration: 1.seconds,
                                          );
                                          return;
                                        }
                                        LatLng myCar = woAuto.parkings
                                            .elementAt(0)
                                            .position;
                                        String link =
                                            'https://www.google.com/maps?q=${myCar.latitude},${myCar.longitude}';
                                        await launchUrl(Uri.parse(link),
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
