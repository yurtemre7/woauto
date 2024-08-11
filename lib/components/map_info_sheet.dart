import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/components/car_bottom_sheet.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';

class MapInfoSheet extends StatefulWidget {
  const MapInfoSheet({super.key});

  @override
  State<MapInfoSheet> createState() => _MapInfoSheetState();
}

class _MapInfoSheetState extends State<MapInfoSheet> {
  final WoAutoServer woAutoServer = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (woAuto.carMarkers.isEmpty && woAuto.friendCarMarkers.isEmpty)
            Container(
              width: 49,
            ),
          if (!woAuto.drivingMode.value &&
              (woAuto.carMarkers.isNotEmpty || woAuto.friendCarMarkers.isNotEmpty))
            Badge(
              alignment: Alignment.topCenter,
              label: Text(t.info_sheet.badge_label),
              isLabelVisible: woAutoServer.shareMyParkings.value,
              child: FloatingActionButton(
                tooltip: t.info_sheet.parkings,
                onPressed: (woAuto.carMarkers.isNotEmpty || woAuto.friendCarMarkers.isNotEmpty)
                    ? () {
                        Get.bottomSheet(
                          const CarBottomSheet(),
                          settings: const RouteSettings(
                            name: 'CarBottomSheet',
                          ),
                        );
                      }
                    : null,
                child: const Icon(
                  Icons.local_parking_outlined,
                ),
              ),
            ),
          FloatingActionButton.extended(
            onPressed: () async {
              var pos = woAuto.currentPosition.value.target;
              if (woAuto.currentSelectedPosition.value != null) {
                pos = woAuto.currentSelectedPosition.value!;
              }
              await woAuto.onNewParking(pos);
              flutterLocalNotificationsPlugin.cancelAll();
              woAuto.tempMarkers.removeWhere((element) => element.markerId.value == 'temp');
              woAuto.currentSelectedPosition.value = null;
              woAuto.currentSelectedCarPark.value = null;
            },
            label: Text(
              t.info_sheet.park_save,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            tooltip: t.info_sheet.park_save,
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
            tooltip: t.info_sheet.current_position,
            child: Icon(
              Icons.location_searching_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
