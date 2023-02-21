import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/text_icon.dart';
import 'package:woauto/providers/woauto.dart';
import 'package:woauto/utils/utilities.dart';

class TopHeader extends StatefulWidget {
  const TopHeader({super.key});

  @override
  State<TopHeader> createState() => _TopHeaderState();
}

final resetPosition = SnappingPosition.factor(
  positionFactor: 1,
  snappingCurve: Curves.easeOutExpo,
  snappingDuration: animationSpeed,
  grabbingContentOffset: GrabbingContentOffset.bottom,
);

class _TopHeaderState extends State<TopHeader> {
  WoAuto get woAutoController => Get.find<WoAuto>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var snapPos = woAutoController.snappingSheetController.value.currentSnappingPosition;
        var offset = snapPos.grabbingContentOffset;
        if (offset > 0) {
          woAutoController.snappingSheetController.value.snapToPosition(
            resetPosition,
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
          name: 'App verlassen',
        );
      },
      child: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        'WoAuto',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Expanded(
                  child: Visibility(
                    visible: woAutoController.pinList.toList().isNotEmpty ||
                        woAutoController.parkingList.toList().isNotEmpty,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: SnappingSheet(
                      controller: woAutoController.snappingSheetController.value,
                      lockOverflowDrag: true,
                      snappingPositions: [
                        resetPosition,
                        SnappingPosition.factor(
                          positionFactor: 0.5,
                          snappingCurve: Curves.bounceOut,
                          snappingDuration: animationSpeed,
                          grabbingContentOffset: GrabbingContentOffset.top,
                        ),
                      ],
                      grabbingHeight: 50,
                      initialSnappingPosition: resetPosition,
                      grabbing: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {},
                                child: Container(
                                  width: 110,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      sheetAbove: SnappingSheetContent(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(
                            //   color: Colors.grey.withOpacity(0.3),
                            // ),
                          ),
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Obx(
                                  () {
                                    var pinList = woAutoController.pinList.toList();
                                    var parkingList = woAutoController.parkingList.toList();
                                    return Column(
                                      children: [
                                        if (parkingList.isNotEmpty) ...[
                                          const SizedBox(height: 15),
                                          const Text(
                                            'Parkplätze',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          ...parkingList.toSet().map(
                                            (element) {
                                              return ListTile(
                                                title: Text(
                                                  element['name'] +
                                                      " - ${element['distance']} m entfernt",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  element['address'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                trailing: PopupMenuButton(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        child: TextIcon(
                                                          icon: Icon(
                                                            Icons.map_outlined,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          label: Text(
                                                            'In Google Maps öffnen',
                                                            style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          launchUrl(
                                                            Uri.parse(
                                                              'https://www.google.com/maps?q=${element['lat']},${element['long']}',
                                                            ),
                                                            mode: LaunchMode.externalApplication,
                                                          );
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                        child: TextIcon(
                                                          icon: Icon(
                                                            Icons.navigation_outlined,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          label: Text(
                                                            'Zum Parkplatz',
                                                            style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          woAutoController
                                                              .snappingSheetController.value
                                                              .snapToPosition(
                                                            resetPosition,
                                                          );
                                                          GoogleMapController controller =
                                                              woAutoController.mapController.value!;
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
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                        child: const TextIcon(
                                                          icon: Icon(
                                                            Icons.delete_outline,
                                                            color: Colors.red,
                                                          ),
                                                          label: Text(
                                                            'Parkplatz löschen',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          var id = element['id'].toString();
                                                          var ids = id.split(',');
                                                          int num = int.parse(ids[1]);
                                                          String type = ids[0];
                                                          if (type == 'park') {
                                                            woAutoController.parkingList
                                                                .removeAt(num);
                                                            woAutoController.parkings.removeWhere(
                                                                (Marker element) =>
                                                                    element.markerId.value == id);
                                                          } else {
                                                            woAutoController.pinList.removeAt(num);
                                                            woAutoController.pins.removeWhere(
                                                                (Marker element) =>
                                                                    element.markerId.value == id);
                                                          }

                                                          woAutoController.markers.clear();
                                                          woAutoController.markers
                                                              .addAll(woAutoController.pins);
                                                          woAutoController.markers
                                                              .addAll(woAutoController.parkings);

                                                          woAutoController.save();

                                                          woAutoController
                                                              .snappingSheetController.value
                                                              .snapToPosition(
                                                            resetPosition,
                                                          );
                                                        },
                                                      ),
                                                    ];
                                                  },
                                                ),
                                                onTap: () {
                                                  GoogleMapController controller =
                                                      woAutoController.mapController.value!;
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
                                                  woAutoController.snappingSheetController.value
                                                      .snapToPosition(
                                                    resetPosition,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                        if (pinList.isNotEmpty) ...[
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Pins',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          ...pinList.toSet().map(
                                            (element) {
                                              return ListTile(
                                                title: Text(
                                                  element['name'] +
                                                      " - ${element['distance']} m entfernt",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  element['address'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                trailing: PopupMenuButton(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        child: TextIcon(
                                                          icon: Icon(
                                                            Icons.map_outlined,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          label: Text(
                                                            'in Google Maps öffnen',
                                                            style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          launchUrl(
                                                            Uri.parse(
                                                              'https://www.google.com/maps?q=${element['lat']},${element['long']}',
                                                            ),
                                                            mode: LaunchMode.externalApplication,
                                                          );
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                        child: TextIcon(
                                                          icon: Icon(
                                                            Icons.navigation_outlined,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          label: Text(
                                                            'Zum Parkplatz',
                                                            style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          GoogleMapController controller =
                                                              woAutoController.mapController.value!;
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
                                                          woAutoController
                                                              .snappingSheetController.value
                                                              .snapToPosition(
                                                            resetPosition,
                                                          );
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                        child: const TextIcon(
                                                          icon: Icon(
                                                            Icons.delete_outline,
                                                            color: Colors.red,
                                                          ),
                                                          label: Text(
                                                            'Parkplatz löschen',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          var id = element['id'].toString();
                                                          var ids = id.split(',');
                                                          int num = int.parse(ids[1]);
                                                          String type = ids[0];
                                                          if (type == 'park') {
                                                            woAutoController.parkingList
                                                                .removeAt(num);
                                                            woAutoController.parkings.removeWhere(
                                                                (Marker element) =>
                                                                    element.markerId.value == id);
                                                          } else {
                                                            woAutoController.pinList.removeAt(num);
                                                            woAutoController.pins.removeWhere(
                                                                (Marker element) =>
                                                                    element.markerId.value == id);
                                                          }

                                                          woAutoController.markers.clear();
                                                          woAutoController.markers
                                                              .addAll(woAutoController.pins);
                                                          woAutoController.markers
                                                              .addAll(woAutoController.parkings);

                                                          woAutoController.save();

                                                          woAutoController
                                                              .snappingSheetController.value
                                                              .snapToPosition(
                                                            resetPosition,
                                                          );
                                                        },
                                                      ),
                                                    ];
                                                  },
                                                ),
                                                onTap: () {
                                                  GoogleMapController controller =
                                                      woAutoController.mapController.value!;
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
                                                  woAutoController.snappingSheetController.value
                                                      .snapToPosition(
                                                    resetPosition,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                        const SizedBox(height: 15),
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
                                              snackPosition: SnackPosition.bottom,
                                              titleText: Text(
                                                'Wie wird die Entfernung berechnet?',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                              messageText: Column(
                                                children: [
                                                  Text(
                                                    'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Theme.of(context).colorScheme.secondary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Tippe um mehr zu erfahren.',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context).colorScheme.primary,
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
                                                  Theme.of(context).colorScheme.surface,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
