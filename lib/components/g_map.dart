import 'dart:async';
import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';
import 'package:timezone/timezone.dart' as tz;

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

    location.changeSettings(
      interval: 500,
    );

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

      if (woAuto.drivingMode.value) {
        if (woAuto.mapController.value != null) {
          woAuto.currentPosition.value = CameraPosition(
            target: LatLng(
              currentLocation.latitude ?? 0,
              currentLocation.longitude ?? 0,
            ),
            zoom: 18,
            bearing: currentLocation.heading ?? 0,
          );
          woAuto.mapController.value!.animateCamera(
            CameraUpdate.newCameraPosition(
              woAuto.currentPosition.value,
            ),
          );
        }
      }

      woAuto.currentVelocity.value = currentLocation.speed ?? 0;

      if (!woAuto.drivingMode.value && woAuto.askForDrivingMode.value) {
        // show dialog to ask the user if he wants to switch to driving mode, IF his velocity is > 5 km/h
        var kmh = ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6);
        if (kmh > 5) {
          if (woAuto.currentIndex.value == 0) {
            woAuto.askForDrivingMode.value = false;
            var result = await Get.dialog(
              AlertDialog(
                title: const Text('Driving Modus erkannt'),
                content: const Text(
                  'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: const Text('NEIN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: const Text('JA'),
                  ),
                ],
              ),
              name: 'Fahrmodus',
            );
            if (result) {
              woAuto.drivingMode.value = true;
            }
          }
        } else {
          if (woAuto.drivingMode.value) {
            woAuto.drivingMode.value = false;
          }
        }
      }
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
              onLongPress: (LatLng newPosition) async {
                // open context menu
                log('Long Pressed at $newPosition');
                // add temporary marker
                woAuto.markers.add(
                  Marker(
                    markerId: const MarkerId('temp'),
                    position: newPosition,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                  ),
                );
                // show dialog
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
                            launchUrl(
                              Uri.parse(
                                'https://www.google.com/maps/search/?api=1&query=${newPosition.latitude},${newPosition.longitude}',
                              ),
                              mode: LaunchMode.externalApplication,
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
                // remove temporary marker
                woAuto.markers.removeWhere((element) => element.markerId.value == 'temp');
              },
              onTap: (LatLng newPosition) {
                if (kDebugMode) {
                  woAuto.printWoAuto();
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
                                        icon: const Icon(Icons.question_mark_outlined),
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

                            bool? res;

                            if (isIOS()) {
                              res = await flutterLocalNotificationsPlugin
                                  .resolvePlatformSpecificImplementation<
                                      IOSFlutterLocalNotificationsPlugin>()
                                  ?.requestPermissions(
                                    alert: true,
                                    badge: true,
                                    sound: true,
                                  );
                            } else if (isAndroid()) {
                              res = await flutterLocalNotificationsPlugin
                                  .resolvePlatformSpecificImplementation<
                                      AndroidFlutterLocalNotificationsPlugin>()
                                  ?.requestPermission();
                            } else {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Benachrichtigungen'),
                                  content: const Text(
                                    'Dein Betriebssystem unterstützt keine Benachrichtigungen.',
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
                              return;
                            }

                            if (res == null || res == false) {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Benachrichtigungen'),
                                  content: const Text(
                                    'Um dir eine Benachrichtigung zu schicken, wenn dein Parkticket abläuft, '
                                    'muss die App die Benachrichtigungen erlauben. '
                                    'Bitte erlaube die Benachrichtigungen und versuche es erneut.',
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
                              return;
                            }

                            await flutterLocalNotificationsPlugin.cancelAll();

                            NotificationDetails notificationDetails =
                                NotificationDetails(android: androidNotificationDetailsMAX);
                            await flutterLocalNotificationsPlugin.show(
                              1,
                              'Auto geparkt',
                              'Dein Parkticket gilt bis ${tillTime.value!.hour.toString().padLeft(2, '0')}:${tillTime.value!.minute.toString().padLeft(2, '0')} Uhr.',
                              notificationDetails,
                            );

                            int minutesLeft = 0;
                            int minutes = woAuto.timePuffer.value * 60;
                            if (differenceInSecondsFromNow > minutes) {
                              differenceInSecondsFromNow -= minutes;
                              minutesLeft = woAuto.timePuffer.value;
                            } else if (differenceInSecondsFromNow < 0) {
                              differenceInSecondsFromNow += 86400 - minutes;
                              minutesLeft = woAuto.timePuffer.value;
                            } else {
                              minutesLeft = differenceInSecondsFromNow ~/ 60;
                            }
                            await flutterLocalNotificationsPlugin.zonedSchedule(
                              0,
                              'Dein Parkticket läuft bald ab',
                              'In ca. $minutesLeft Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.',
                              tz.TZDateTime.now(tz.local)
                                  .add(Duration(seconds: differenceInSecondsFromNow)),
                              NotificationDetails(
                                android: androidNotificationDetails,
                              ),
                              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
                              uiLocalNotificationDateInterpretation:
                                  UILocalNotificationDateInterpretation.absoluteTime,
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
}
