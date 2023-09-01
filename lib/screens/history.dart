import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:to_csv/to_csv.dart';
import 'package:uuid/uuid.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<CarPark> getLastParks(List<CarPark> history) {
    List<CarPark> parks = [];
    for (CarPark park in history) {
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
                      name: 'Historie Info',
                    );
                  },
                  icon: const Icon(Icons.question_mark_outlined),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  16.h,
                  Obx(
                    () {
                      var history = woAuto.carParkingHistory.reversed.toList();
                      return Column(
                        children: [
                          if (history.isEmpty)
                            const ListTile(
                              title: Text('Keine Einträge'),
                              subtitle: Text('Du hast noch keine Einträge in deiner Historie.'),
                            ),
                          ...getLastParks(history).map(
                            (park) => Dismissible(
                              key: Key(const Uuid().v4()),
                              onDismissed: (direction) {
                                woAuto.carParkingHistory.remove(park);
                                woAuto.save();
                              },
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: const Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.navigation_outlined,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                title: Text(park.name),
                                subtitle: Text(park.adresse ?? 'Unbekannt'),
                                trailing: Text(
                                  formatDateTimeToTimeAndDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      park.createdAt ?? DateTime.now().millisecondsSinceEpoch,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  woAuto.currentIndex.value = 0;
                                  GoogleMapController controller = woAuto.mapController.value!;
                                  await controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: park.latLng,
                                        zoom: CAM_ZOOM,
                                      ),
                                    ),
                                  );
                                  var m = Marker(
                                    markerId: const MarkerId('temp'),
                                    position: LatLng(
                                      park.latitude,
                                      park.longitude,
                                    ),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueAzure,
                                    ),
                                  );
                                  woAuto.tempMarkers
                                      .removeWhere((element) => element.markerId.value == 'temp');
                                  woAuto.tempMarkers.add(m);
                                  woAuto.tempMarkers.refresh();
                                },
                              ),
                            ),
                          ),
                          if (history.isNotEmpty) ...[
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
                                for (CarPark park in woAuto.carParkingHistory) {
                                  rows.add(
                                    [
                                      park.name,
                                      park.adresse ?? 'Unbekannt',
                                      DateTime.fromMillisecondsSinceEpoch(park.createdAt ??
                                              DateTime.now().millisecondsSinceEpoch)
                                          .toString(),
                                      park.latitude.toString(),
                                      park.longitude.toString(),
                                      park.description ?? '',
                                    ],
                                  );
                                }
                                await myCSV(header, rows);
                              },
                            ),
                            ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              title: Text(
                                'Historie löschen',
                                style: TextStyle(color: Theme.of(context).colorScheme.error),
                              ),
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
                                          foregroundColor: Theme.of(context).colorScheme.error,
                                        ),
                                        child: const Text('Löschen'),
                                        onPressed: () async {
                                          pop();

                                          woAuto.carParkingHistory.clear();
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
                                  name: 'Historie löschen',
                                );
                              },
                            ),
                          ],
                          16.h,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
