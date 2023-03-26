import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woauto/components/top_header.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class MapInfoSheet extends StatefulWidget {
  const MapInfoSheet({super.key});

  @override
  State<MapInfoSheet> createState() => _MapInfoSheetState();
}

class _MapInfoSheetState extends State<MapInfoSheet> {
  bool up = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          if (woAuto.currentVelocity.value >= 3.0) {
            return Column(
              children: [
                Text(
                  '${((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6).toStringAsFixed(1)} km/h',
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
          () => Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (woAuto.parkingList.isEmpty) const IconButton(onPressed: null, icon: Icon(null)),
                if (woAuto.parkingList.isNotEmpty)
                  FittedBox(
                    child: SizedBox(
                      height: 50,
                      child: FloatingActionButton(
                        tooltip: 'Parkplatz teilen',
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
                        },
                        child: Icon(
                          Icons.share,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                FittedBox(
                  child: SizedBox(
                    height: 50,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        if (kDebugMode) {
                          woAuto.printWoAuto();
                        }
                        if (woAuto.snappingSheetController.value.isAttached) {
                          var snapPos =
                              woAuto.snappingSheetController.value.currentSnappingPosition;
                          var offset = snapPos.grabbingContentOffset;

                          if (offset > 0) {
                            woAuto.snappingSheetController.value.snapToPosition(
                              resetPosition,
                            );
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
                                          const SizedBox(height: 5),
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
                                                          data: MediaQuery.of(context).copyWith(
                                                              alwaysUse24HourFormat: true),
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
                                  const SizedBox(height: 10),
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
                      icon: const Icon(Icons.local_parking_rounded),
                    ),
                  ),
                ),
                FittedBox(
                  child: SizedBox(
                    height: 50,
                    child: FloatingActionButton(
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
                        Icons.location_searching,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
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
