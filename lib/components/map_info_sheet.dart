import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
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
                        woAuto.currentPosition.value.target,
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
                            target: woAuto.currentPosition.value.target,
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
    );
  }
}
