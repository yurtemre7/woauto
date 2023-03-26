import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/text_icon.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class TopHeader extends StatefulWidget {
  const TopHeader({super.key});

  @override
  State<TopHeader> createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WoAuto',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        style: IconButton.styleFrom(
                          foregroundColor: context.theme.colorScheme.primary,
                          disabledForegroundColor: Colors.grey.withOpacity(0.3),
                        ),
                        onPressed: woAuto.pinList.toList().isNotEmpty ||
                                woAuto.parkingList.toList().isNotEmpty
                            ? () {
                                Get.bottomSheet(
                                  const CarBottomSheet(),
                                  settings: const RouteSettings(name: 'CarBottomSheet'),
                                );
                              }
                            : null,
                        icon: const Icon(
                          Icons.directions_car_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarBottomSheet extends StatefulWidget {
  const CarBottomSheet({super.key});

  @override
  State<CarBottomSheet> createState() => _CarBottomSheetState();
}

class _CarBottomSheetState extends State<CarBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(children: [
              Obx(
                () {
                  var pinList = woAuto.pinList.toList();
                  var parkingList = woAuto.parkingList.toList();
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
                                element['name'] + " - ${element['distance']} m entfernt",
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
                              trailing: PopupMenuButton<int>(
                                icon: Icon(
                                  Icons.more_vert_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onSelected: (value) {
                                  switch (value) {
                                    case 0:
                                      launchUrl(
                                        Uri.parse(
                                          'https://www.google.com/maps?q=${element['lat']},${element['long']}',
                                        ),
                                        mode: LaunchMode.externalApplication,
                                      );
                                      break;
                                    case 1:
                                      GoogleMapController controller = woAuto.mapController.value!;
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
                                      break;
                                    case 2:
                                      var id = element['id'].toString();
                                      var ids = id.split(',');
                                      int num = int.parse(ids[1]);
                                      String type = ids[0];
                                      if (type == 'park') {
                                        woAuto.parkingList.removeAt(num);
                                        woAuto.parkings.removeWhere(
                                            (Marker element) => element.markerId.value == id);
                                      } else {
                                        woAuto.pinList.removeAt(num);
                                        woAuto.pins.removeWhere(
                                            (Marker element) => element.markerId.value == id);
                                      }

                                      woAuto.markers.clear();
                                      woAuto.markers.addAll(woAuto.pins);
                                      woAuto.markers.addAll(woAuto.parkings);

                                      woAuto.save();
                                      break;
                                  }
                                  pop();
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 0,
                                      child: TextIcon(
                                        icon: Icon(
                                          Icons.map_outlined,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        label: Text(
                                          'In Google Maps öffnen',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: TextIcon(
                                        icon: Icon(
                                          Icons.navigation_outlined,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        label: Text(
                                          'Zum Parkplatz',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: TextIcon(
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
                                    ),
                                  ];
                                },
                              ),
                              onTap: () {
                                GoogleMapController controller = woAuto.mapController.value!;
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
                                pop();
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
                                element['name'] + " - ${element['distance']} m entfernt",
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
                              trailing: PopupMenuButton<int>(
                                icon: Icon(
                                  Icons.more_vert_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onSelected: (value) {
                                  switch (value) {
                                    case 0:
                                      launchUrl(
                                        Uri.parse(
                                          'https://www.google.com/maps?q=${element['lat']},${element['long']}',
                                        ),
                                        mode: LaunchMode.externalApplication,
                                      );
                                      break;
                                    case 1:
                                      GoogleMapController controller = woAuto.mapController.value!;
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
                                      break;
                                    case 2:
                                      var id = element['id'].toString();
                                      var ids = id.split(',');
                                      int num = int.parse(ids[1]);
                                      String type = ids[0];
                                      if (type == 'park') {
                                        woAuto.parkingList.removeAt(num);
                                        woAuto.parkings.removeWhere(
                                            (Marker element) => element.markerId.value == id);
                                      } else {
                                        woAuto.pinList.removeAt(num);
                                        woAuto.pins.removeWhere(
                                            (Marker element) => element.markerId.value == id);
                                      }

                                      woAuto.markers.clear();
                                      woAuto.markers.addAll(woAuto.pins);
                                      woAuto.markers.addAll(woAuto.parkings);

                                      woAuto.save();
                                      break;
                                  }
                                  pop();
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 0,
                                      child: TextIcon(
                                        icon: Icon(
                                          Icons.map_outlined,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        label: Text(
                                          'in Google Maps öffnen',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: TextIcon(
                                        icon: Icon(
                                          Icons.navigation_outlined,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        label: Text(
                                          'Zum Parkplatz',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: TextIcon(
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
                                    ),
                                  ];
                                },
                              ),
                              onTap: () {
                                GoogleMapController controller = woAuto.mapController.value!;
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
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: 15),
                      TextButton.icon(
                        icon: const Icon(Icons.question_mark_outlined),
                        label: const Text(
                          'Wie wird die Entfernung berechnet, fragst du dich?',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Get.snackbar(
                            'Wie wird die Entfernung berechnet?',
                            'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                            snackPosition: SnackPosition.TOP,
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
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(height: 16),
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
                            backgroundColor: Theme.of(context).colorScheme.surface,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
