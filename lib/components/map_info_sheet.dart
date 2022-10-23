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
  ScrollController scrollController = ScrollController();
  late SnappingSheetController snappingSheetController;

  bool up = false;

  @override
  void initState() {
    super.initState();
    snappingSheetController = woAuto.snappingSheetController.value;
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
                      var snapPos = snappingSheetController.currentSnappingPosition;
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

                                    if (woAuto.mapController.value == null) {
                                      return;
                                    }

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
                                    }

                                    woAuto.mapController.value!.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: woAuto.currentPosition.value.target,
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
                padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 10),
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
                          label: const Text('Parkplatz Teilen'),
                          onPressed: () {
                            // share parking location to whatsapp, telegram etc.
                            if (woAuto.parkings.isEmpty) {
                              // show snackbar error
                              Get.snackbar(
                                'Fehler',
                                'Keinen Parkplatz gespeichert',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                duration: 2.seconds,
                              );
                              return;
                            }
                            var textEditing = TextEditingController(text: woAuto.subText.value);

                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text('Parkplatz teilen'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Du kannst den Parkplatz mit deinen Freunden teilen.',
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Welchen Namen soll der Parkplatz haben?'),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: textEditing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Name',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Tipp: Wenn dein Freund auch die App nutzt, kann er den Parkplatz in der App auch einsehen mit dem neuen Link.',
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('ABBRECHEN'),
                                    onPressed: () {
                                      pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('TEILEN'),
                                    onPressed: () async {
                                      if (textEditing.text.isEmpty) {
                                        // show snackbar error
                                        Get.snackbar(
                                          'Fehler',
                                          'Keinen Name eingegeben',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.redAccent,
                                          borderRadius: 10,
                                          margin: const EdgeInsets.all(10),
                                          duration: 2.seconds,
                                        );
                                        return;
                                      }
                                      if (woAuto.parkings.isEmpty) {
                                        // show snackbar error
                                        Get.snackbar(
                                          'Fehler',
                                          'Keinen Parkplatz gespeichert',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.redAccent,
                                          borderRadius: 10,
                                          margin: const EdgeInsets.all(10),
                                          duration: 2.seconds,
                                        );
                                        return;
                                      }
                                      LatLng myCar = woAuto.parkings.elementAt(0).position;
                                      String website = 'https://yurtemre.de';
                                      String link =
                                          'https://www.google.com/maps?q=${myCar.latitude},${myCar.longitude}';
                                      String woLink =
                                          '$website/deeplink?title=${Uri.encodeFull(textEditing.text)}&lat=${Uri.encodeFull(myCar.latitude.toString())}&long=${Uri.encodeFull(myCar.longitude.toString())}';
                                      String text =
                                          'Ich habe meinen Wagen hier geparkt: $woLink\n\n';

                                      text +=
                                          'Alternativ kannst du ihn auch über Google Maps einsehen: $link';

                                      pop();
                                      Share.share(text);
                                    },
                                  ),
                                ],
                              ),
                            );
                            return;
                          },
                        ),

                        TextButton.icon(
                          onPressed: () async {
                            GoogleMapController controller = woAuto.mapController.value!;
                            controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                woAuto.currentPosition.value,
                              ),
                            );

                            snappingSheetController.snapToPosition(
                              SnappingPosition.factor(
                                positionFactor: 0.0,
                                snappingCurve: Curves.easeOutExpo,
                                snappingDuration: 1300.milliseconds,
                                grabbingContentOffset: GrabbingContentOffset.top,
                              ),
                            );
                          },
                          icon: const Icon(Icons.location_on_outlined),
                          label: const Text('Gehe zu meinem Standort'),
                        ),

                        // infos about your parking spot
                        Obx(
                          () {
                            var pinList = woAuto.pinList.toList();
                            var parkingList = woAuto.parkingList.toList();
                            return Visibility(
                              visible: parkingList.isNotEmpty || pinList.isNotEmpty,
                              child: Column(
                                children: [
                                  if (parkingList.isNotEmpty || pinList.isNotEmpty) ...[
                                    const Div(),
                                  ],
                                  if (parkingList.isNotEmpty) ...[
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Information - Parkplätze',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    ...parkingList.toSet().map(
                                      (element) {
                                        return ListTile(
                                          title: Text(
                                            element['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            element['adresse'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Text("${element['distance']} m"),
                                          onTap: () {
                                            GoogleMapController controller =
                                                woAuto.mapController.value!;
                                            controller.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    element['lat'],
                                                    element['long'],
                                                  ),
                                                  zoom: 18,
                                                ),
                                              ),
                                            );
                                            snappingSheetController.snapToPosition(
                                              SnappingPosition.factor(
                                                positionFactor: 0.0,
                                                snappingCurve: Curves.easeOutExpo,
                                                snappingDuration: 1300.milliseconds,
                                                grabbingContentOffset: GrabbingContentOffset.top,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                  if (pinList.isNotEmpty) ...[
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Information - Pins',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    ...pinList.toSet().map(
                                      (element) {
                                        return ListTile(
                                          title: Text(
                                            element['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            element['adresse'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Text("${element['distance']} m"),
                                          onTap: () {
                                            GoogleMapController controller =
                                                woAuto.mapController.value!;
                                            controller.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    element['lat'],
                                                    element['long'],
                                                  ),
                                                  zoom: 18,
                                                ),
                                              ),
                                            );
                                            snappingSheetController.snapToPosition(
                                              SnappingPosition.factor(
                                                positionFactor: 0.0,
                                                snappingCurve: Curves.easeOutExpo,
                                                snappingDuration: 1300.milliseconds,
                                                grabbingContentOffset: GrabbingContentOffset.top,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                  const SizedBox(height: 10),
                                  TextButton.icon(
                                    icon: const Icon(Icons.question_mark),
                                    label: const Text(
                                      'Wie wird die Entfernung berechnet, fragst du dich?',
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Get.snackbar(
                                        'Wie wird die Entfernung berechnet?',
                                        'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        titleText: const Text(
                                          'Wie wird die Entfernung berechnet?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        messageText: Column(
                                          children: const [
                                            Text(
                                              'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Tippe um mehr zu erfahren.',
                                              style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                        borderRadius: 12,
                                        margin: const EdgeInsets.all(20),
                                        duration: 10.seconds,
                                        onTap: (snack) {
                                          launchUrl(
                                            Uri.parse(
                                              'https://en.wikipedia.org/wiki/Haversine_formula',
                                            ),
                                            mode: LaunchMode.externalApplication,
                                          );
                                        },
                                        backgroundColor:
                                            getBackgroundColor(context)?.withOpacity(0.5),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),

                                  //   Text(
                                  //   '${formatDateTimeAndTime(woAuto.datum.value)}:',
                                  // ),
                                  // const SizedBox(height: 5),
                                  // if (address == null)
                                  //   const Text(
                                  //     'Ein Fehler beim Herausfinden der Parkadresse ist aufgetreten.',
                                  //   ),
                                  // if (address != null && address.isEmpty)
                                  //   const Text(
                                  //     'Keine Adresse gefunden.',
                                  //   ),
                                  // if (address != null && address.isNotEmpty)
                                  //   TextButton.icon(
                                  //     label: Text(
                                  //       address.toString(),
                                  //       style: const TextStyle(
                                  //         fontSize: 16,
                                  //         decoration: TextDecoration.underline,
                                  //       ),
                                  //     ),
                                  //     icon: const Icon(Icons.map),
                                  //     onPressed: () async {
                                  //       if (woAuto.parkings.isEmpty) {
                                  //         // show snackbar error
                                  //         Get.snackbar(
                                  //           'Fehler',
                                  //           'Kein Parkplatz gespeichert',
                                  //           snackPosition: SnackPosition.BOTTOM,
                                  //           backgroundColor: Colors.red,
                                  //           borderRadius: 10,
                                  //           margin: const EdgeInsets.all(10),
                                  //           duration: 1.seconds,
                                  //         );
                                  //         return;
                                  //       }
                                  //       LatLng myCar = woAuto.parkings.elementAt(0).position;
                                  //       String link =
                                  //           'https://www.google.com/maps?q=${myCar.latitude},${myCar.longitude}';
                                  //       await launchUrl(
                                  //         Uri.parse(link),
                                  //         mode: LaunchMode.externalApplication,
                                  //       );
                                  //     },
                                  //   ),
                                  // const SizedBox(height: 5),
                                  // TextButton.icon(
                                  //   icon: const Icon(Icons.question_mark),
                                  //   label: Text(
                                  //     'Parkplatz ist π-mal-Daumen\n${woAuto.distance.value} Meter entfernt',
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  //   onPressed: () {
                                  //     Get.snackbar(
                                  //       'Wie wird die Entfernung berechnet?',
                                  //       'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                  //       snackPosition: SnackPosition.BOTTOM,
                                  //       titleText: const Text(
                                  //         'Wie wird die Entfernung berechnet?',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 16,
                                  //         ),
                                  //       ),
                                  //       messageText: Column(
                                  //         children: const [
                                  //           Text(
                                  //             'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                  //             style: TextStyle(
                                  //               fontSize: 14,
                                  //             ),
                                  //           ),
                                  //           SizedBox(height: 10),
                                  //           Text(
                                  //             'Tippe um mehr zu erfahren.',
                                  //             style: TextStyle(
                                  //               fontSize: 14,
                                  //               decoration: TextDecoration.underline,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       borderRadius: 12,
                                  //       margin: const EdgeInsets.all(20),
                                  //       duration: 10.seconds,
                                  //       onTap: (snack) {
                                  //         launchUrl(
                                  //           Uri.parse(
                                  //             'https://en.wikipedia.org/wiki/Haversine_formula',
                                  //           ),
                                  //           mode: LaunchMode.externalApplication,
                                  //         );
                                  //       },
                                  //       backgroundColor:
                                  //           getBackgroundColor(context)?.withOpacity(0.5),
                                  //     );
                                  //   },
                                  // ),
                                  // const SizedBox(height: 10),
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
