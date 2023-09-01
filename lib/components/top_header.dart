import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/components/text_icon.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WoAuto',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.primary,
                      ),
                    ),
                    Obx(
                      () {
                        var kmh =
                            ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ??
                                    0) *
                                3.6);
                        return Row(
                          children: [
                            if (woAuto.drivingMode.value) ...[
                              if (woAuto.currentVelocity.value >= 0.0)
                                Text(
                                  '${kmh.toStringAsFixed(1)} km/h',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              8.w,
                            ],
                            if (!woAuto.drivingMode.value)
                              IconButton(
                                tooltip: 'Parkplätze',
                                style: IconButton.styleFrom(
                                  foregroundColor: context.theme.colorScheme.primary,
                                  disabledForegroundColor: Colors.grey.withOpacity(0.3),
                                ),
                                onPressed: woAuto.carMarkers.isNotEmpty
                                    ? () {
                                        Get.bottomSheet(
                                          const CarBottomSheet(),
                                          settings: const RouteSettings(
                                            name: 'CarBottomSheet',
                                          ),
                                        );
                                      }
                                    : null,
                                icon: const Icon(
                                  Icons.local_parking_outlined,
                                ),
                                iconSize: 30,
                              ),
                            IconButton(
                              tooltip: 'Driving Modus',
                              style: IconButton.styleFrom(
                                foregroundColor: context.theme.colorScheme.primary,
                                disabledForegroundColor: Colors.grey.withOpacity(0.3),
                              ),
                              onPressed: () {
                                woAuto.drivingMode.toggle();
                              },
                              icon: Icon(
                                woAuto.drivingMode.value
                                    ? Icons.directions_car
                                    : Icons.directions_walk,
                              ),
                              iconSize: 30,
                            ),
                          ],
                        );
                      },
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
  final woAutoServer = Get.find<WoAutoServer>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // border: Border.all(
        //   color: Colors.grey.withOpacity(0.3),
        // ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    var carParkingList = woAuto.carParkings.toList();

                    var myParking = carParkingList.where((element) => element.mine);
                    var otherParking = carParkingList.where((element) => !element.mine);

                    return Column(
                      children: [
                        if (carParkingList.isNotEmpty) ...[
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Parkplätze',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: () {
                                  for (var element in myParking) {
                                    if (element.sharing) {
                                      woAutoServer.updateLocation(park: element);
                                    }
                                  }
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Aktualisieren'),
                              ),
                            ],
                          ),
                          if (myParking.isEmpty)
                            const Text(
                              'Du hast keine Parkplätze.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ...myParking
                              .map(
                                (park) => buildParkTile(park, context),
                              )
                              .toList(),
                          const Div(),
                          Row(
                            children: [
                              const Text(
                                'Geteilte Parkplätze',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: () {
                                  for (var element in otherParking) {
                                    if (element.sharing) {
                                      woAutoServer.getLocation(
                                        id: element.uuid,
                                        view: element.viewKey,
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Aktualisieren'),
                              ),
                            ],
                          ),
                          if (otherParking.isEmpty)
                            const Text(
                              'Du hast keine geteilten Parkplätze.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ...otherParking
                              .map(
                                (park) => buildParkTile(park, context),
                              )
                              .toList(),
                        ],
                        const Div(),
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
                                  16.h,
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
                              colorText: Theme.of(context).colorScheme.onSurface,
                            );
                          },
                        ),
                        15.h,
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildParkTile(CarPark park, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        icon: Icon(
          park.sharing ? Icons.sync_sharp : Icons.sync_disabled_sharp,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: !park.sharing
            ? () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Parkplatz synchronisieren'),
                    content: const Text(
                      'Möchtest du den Parkplatz synchronisieren?',
                    ),
                    actions: [
                      TextButton(
                        child: const Text('ABBRECHEN'),
                        onPressed: () => Get.back(result: false),
                      ),
                      ElevatedButton(
                        child: const Text('SYNCHRONISIEREN'),
                        onPressed: () async {
                          int until = DateTime.now().add(30.days).millisecondsSinceEpoch;
                          var acc = await woAutoServer.createLocation(park, until.toString());
                          if (acc == null) {
                            Get.back(result: false);
                            if (!mounted) return;
                            Get.snackbar(
                              'Fehler',
                              'Es ist ein Fehler aufgetreten.',
                              snackPosition: SnackPosition.TOP,
                              titleText: Text(
                                'Fehler',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              messageText: Text(
                                'Es ist ein Fehler aufgetreten.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              borderRadius: 12,
                              margin: const EdgeInsets.all(20),
                              duration: 10.seconds,
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              colorText: Theme.of(context).colorScheme.onSurface,
                            );
                            return;
                          }

                          park.sharing = true;
                          park.viewKey = acc.viewKey;
                          park.editKey = acc.editKey;
                          park.until = until;
                          woAuto.save();

                          Get.back(result: true);
                          setState(() {});
                        },
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  name: 'Parkplatz synchronisieren',
                );
              }
            : () async {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Parkplatz synchronisiert'),
                    content: const Text(
                      'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?',
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('LÖSCHEN'),
                        onPressed: () async {
                          // Delete ... id and edit
                        },
                      ),
                      ElevatedButton(
                        child: const Text('TEILEN'),
                        onPressed: () async {
                          var account =
                              woAutoServer.accounts.values.firstWhere((acc) => acc.id == park.uuid);
                          String website = 'https://yurtemre.de';
                          String woLink =
                              '$website/sync?id=${Uri.encodeFull(account.id)}&view=${Uri.encodeFull(account.viewKey)}&name=${Uri.encodeFull(park.name)}';
                          Share.share(
                            'Hier ist mein synchronisierter Parkplatz:\n$woLink',
                          );
                          Get.back();
                        },
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  name: 'Parkplatz synchronisiert Info',
                );
              },
      ),
      title: Text(
        '${park.name} - ${woAuto.getCarParkDistance(park)}m',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text(
        park.adresse ?? 'Keine Adresse gefunden',
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
              MapsLauncher.launchCoordinates(
                park.latitude,
                park.longitude,
              );
              break;
            case 1:
              GoogleMapController controller = woAuto.mapController.value!;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: park.latLng,
                    zoom: CAM_ZOOM,
                  ),
                ),
              );
              break;
            case 2:
              woAuto.carParkings.removeWhere((element) => element.uuid == park.uuid);
              woAuto.carParkings.refresh();

              flutterLocalNotificationsPlugin.cancelAll();
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
            PopupMenuItem(
              value: 2,
              child: TextIcon(
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  'Parkplatz löschen',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
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
              target: park.latLng,
              zoom: CAM_ZOOM,
            ),
          ),
        );
        pop();
      },
    );
  }
}
