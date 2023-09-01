import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> with WidgetsBindingObserver {
  final mapLoading = true.obs;
  final WoAutoServer woAutoServer = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadPositionData();
    fetchSyncLocations();
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
        zoom: CAM_ZOOM,
      );

      if (woAuto.drivingMode.value) {
        if (woAuto.mapController.value != null) {
          woAuto.currentPosition.value = CameraPosition(
            target: LatLng(
              currentLocation.latitude ?? 0,
              currentLocation.longitude ?? 0,
            ),
            zoom: CAM_ZOOM,
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

      if (!mounted) {
        return;
      }

      if (!woAuto.drivingMode.value && woAuto.askForDrivingMode.value) {
        // show dialog to ask the user if he wants to switch to driving mode, IF his velocity is > woAuto.drivingModeDetectionSpeed.value
        var kmh = ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6);

        if (kmh > woAuto.drivingModeDetectionSpeed.value) {
          if (woAuto.currentIndex.value == 0) {
            woAuto.askForDrivingMode.value = false;
            var result = await Get.dialog<bool?>(
              AlertDialog(
                title: const Text('Driving Modus erkannt'),
                content: const Text(
                  'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      pop(result: false);
                    },
                    child: const Text('NEIN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pop(result: true);
                    },
                    child: const Text('JA'),
                  ),
                ],
              ),
              name: 'Fahrmodus',
            );
            if (result != null && result) {
              woAuto.drivingMode.value = true;
            }
          }
        }
      }
    });
  }

  Future<void> fetchSyncLocations() async {
    logMessage('Fetching positions...');
    var carParkingList = woAuto.carParkings.toList();
    var myParking = carParkingList.where((element) => element.mine);
    var otherParking = carParkingList.where((element) => !element.mine);

    for (var element in myParking) {
      if (element.sharing) {
        woAutoServer.updateLocation(park: element);
      }
    }

    for (var element in otherParking) {
      if (element.sharing) {
        var loc = await woAutoServer.getLocation(id: element.uuid, view: element.viewKey);
        if (loc == null) {
          logMessage('Couldn\'t fetch location for ${element.name} (${element.uuid})');
          // remove from sync list
          woAuto.carParkings.removeWhere((e) => e.uuid == element.uuid);
          woAuto.carParkings.refresh();
          continue;
        }
        logMessage('Adding fetched location for ${element.name} (${element.uuid})');
        woAuto.addAnotherCarPark(
          newPosition: LatLng(double.parse(loc.lat), double.parse(loc.long)),
          uuid: element.uuid,
          view: loc.view,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                  zoom: CAM_ZOOM,
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
              markers: woAuto.carMarkers.toSet()..addAll(woAuto.tempMarkers.toSet()),
              onLongPress: (LatLng newPosition) async {
                logMessage('Long Pressed at $newPosition');
                woAuto.tempMarkers.add(
                  Marker(
                    markerId: const MarkerId('temp'),
                    position: newPosition,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                  ),
                );
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
                            MapsLauncher.launchCoordinates(
                              newPosition.latitude,
                              newPosition.longitude,
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
                flutterLocalNotificationsPlugin.cancelAll();
                woAuto.tempMarkers.removeWhere((element) => element.markerId.value == 'temp');
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
                          woAuto.addCarPark(
                            newPosition,
                            extra: textController.text,
                            newName: newNameController.text,
                          );

                          woAuto.addParkticketNotification(tillTime.value);

                          pop();
                          if (woAuto.mapController.value == null) {
                            return;
                          }
                          await woAuto.mapController.value!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: newPosition,
                                zoom: CAM_ZOOM,
                              ),
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
