import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class MapInfoSheet extends StatefulWidget {
  const MapInfoSheet({super.key});

  @override
  State<MapInfoSheet> createState() => _MapInfoSheetState();
}

class _MapInfoSheetState extends State<MapInfoSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          var kmh = ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6);
          if (woAuto.currentVelocity.value >= 3.0) {
            return Column(
              children: [
                Text(
                  '${kmh.toStringAsFixed(1)} km/h',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            );
          }
          return const SizedBox();
        }),
        Obx(
          () => AnimatedContainer(
            duration: 500.milliseconds,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  tooltip: 'Parkplatz teilen',
                  onPressed: woAuto.parkingList.isNotEmpty
                      ? () {
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
                                  16.h,
                                  TextField(
                                    controller: textEditing,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Parkplatz Name',
                                      hintText: 'Name',
                                    ),
                                  ),
                                  16.h,
                                  const Text(
                                    'Tipp: Wenn dein Freund die App installiert hat, kann er den Parkplatz direkt in der App öffnen.',
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
                                    if (textEditing.text.replaceAll(' ', '').trim().isEmpty) {
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
                                        '$website/deeplink?title=${Uri.encodeFull(textEditing.text.trim())}&lat=${Uri.encodeFull(myCar.latitude.toString())}&long=${Uri.encodeFull(myCar.longitude.toString())}';
                                    String text = 'Ich habe meinen Wagen hier geparkt: $woLink\n\n';

                                    text +=
                                        'Alternativ kannst du ihn auch über Google Maps einsehen: $link';

                                    pop();
                                    Share.share(text);
                                  },
                                ),
                              ],
                            ),
                            name: 'Parkplatz teilen',
                          );
                          return;
                        }
                      : null,
                  child: Icon(
                    Icons.share_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
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
                                woAuto.currentPosition.value.target,
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
                                //   title = 'Dein Parkticket hält noch 10 Minuten an.';
                                // } else if (differenceInSecondsFromNow < 0) {
                                //   differenceInSecondsFromNow += 86400 - 600;
                                //   title = 'Dein Parkticket hält noch 10 Minuten an.';
                                // } else {
                                //   title = 'Dein Parkticket ist abgelaufen.';
                                // }

                                FlutterAlarmClock.createTimer(
                                  differenceInSecondsFromNow,
                                  title: title,
                                );
                              }

                              if (woAuto.mapController.value == null) {
                                return;
                              }
                              pop();
                              woAuto.mapController.value!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: woAuto.currentPosition.value.target,
                                    zoom: 18,
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
                  label: const Text(
                    'Parkplatz speichern',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(Icons.local_parking_outlined),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    GoogleMapController controller = woAuto.mapController.value!;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        woAuto.currentPosition.value,
                      ),
                    );
                  },
                  tooltip: 'Zur aktuellen Position',
                  child: Icon(
                    Icons.location_searching_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
