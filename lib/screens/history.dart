import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Scaffold(
        // backgroundColor: getBackgroundColor(context),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
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
                            ...woAuto.parkHistory.reversed.map(
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
                                  pop();
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
                                    SnappingPosition.factor(
                                      positionFactor: 0.0,
                                      snappingCurve: Curves.easeOutExpo,
                                      snappingDuration: animationSpeed,
                                      grabbingContentOffset: GrabbingContentOffset.top,
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (woAuto.parkHistory.isNotEmpty) ...[
                              const Div(),
                              ListTile(
                                leading: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                title: const Text('Historie löschen'),
                                subtitle: const Text(
                                    'Halte hier gedrückt, um deine Historie zu löschen.'),
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
      ),
    );
  }
}
