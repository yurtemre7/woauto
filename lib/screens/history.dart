import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:to_csv/to_csv.dart';
import 'package:woauto/classes/park.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/components/top_header.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Park> getLastParks(List<Park> history) {
    List<Park> parks = [];
    for (Park park in history) {
      if (parks.length < 15) {
        parks.add(park);
      }
    }
    return parks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: getBackgroundColor(context),
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                expandedHeight: 100.0,
                forceElevated: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(
                    bottom: 14.0,
                    left: 20.0,
                  ),
                  title: Text(
                    'Historie',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: getForegroundColor(context),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      Get.dialog(
                        const AlertDialog(
                          title: Text('Historie'),
                          content: Text('Hier werden dir die letzten 15 Parkplätze angezeigt.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.question_mark),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    const SizedBox(height: 10),
                    Obx(
                      () => Column(
                        children: [
                          if (woAuto.parkHistory.isEmpty)
                            const ListTile(
                              title: Text('Keine Einträge'),
                              subtitle: Text('Du hast noch keine Einträge in deiner Historie.'),
                            ),
                          ...getLastParks(woAuto.parkHistory.reversed.toList()).map(
                            (e) => ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.navigation_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(e.name ?? 'Unbekannt'),
                              subtitle: Text(e.address ?? 'Unbekannt'),
                              trailing: Text(
                                formatDateTimeAndTime(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    e.datum ?? DateTime.now().millisecondsSinceEpoch,
                                  ),
                                ),
                              ),
                              onTap: () {
                                woAuto.currentIndex.value = 0;
                                GoogleMapController controller = woAuto.mapController.value!;
                                controller.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        e.latitude,
                                        e.longitude,
                                      ),
                                      zoom: 18,
                                    ),
                                  ),
                                );
                                // add temporary marker
                                var m = Marker(
                                  markerId: const MarkerId('temp'),
                                  position: LatLng(
                                    e.latitude,
                                    e.longitude,
                                  ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueAzure,
                                  ),
                                );
                                woAuto.markers
                                    .removeWhere((element) => element.markerId.value == 'temp');
                                woAuto.markers.add(m);
                                woAuto.snappingSheetController.value.snapToPosition(
                                  resetPosition,
                                );
                              },
                            ),
                          ),
                          if (woAuto.parkHistory.isNotEmpty) ...[
                            const Div(),
                            ListTile(
                              title: Text(
                                'Exportiere als CSV',
                                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                              ),
                              subtitle: const Text(
                                  'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.'),
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.table_rows_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onTap: () async {
                                List<String> header = [
                                  'Name',
                                  'Adresse',
                                  'Datum',
                                  'Latitude',
                                  'Longitude',
                                  'Extra'
                                ];
                                List<List<String>> rows = [];
                                for (Park park in woAuto.parkHistory) {
                                  rows.add(
                                    [
                                      park.name ?? 'Unbekannt',
                                      park.address ?? 'Unbekannt',
                                      DateTime.fromMillisecondsSinceEpoch(
                                              park.datum ?? DateTime.now().millisecondsSinceEpoch)
                                          .toString(),
                                      park.latitude.toString(),
                                      park.longitude.toString(),
                                      park.extra,
                                    ],
                                  );
                                }
                                await myCSV(header, rows);
                              },
                            ),
                            ListTile(
                              leading: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                              ),
                              title: const Text('Historie löschen'),
                              subtitle:
                                  const Text('Halte hier gedrückt, um deine Historie zu löschen.'),
                              onLongPress: () {
                                Get.dialog(
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text('Historie löschen'),
                                    content: const Text('Möchtest du deine Historie löschen?'),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                        child: const Text('Löschen'),
                                        onPressed: () async {
                                          pop();

                                          woAuto.parkHistory.clear();
                                          woAuto.save();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Abbrechen'),
                                        onPressed: () {
                                          pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
