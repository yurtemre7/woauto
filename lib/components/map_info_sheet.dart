import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/components/car_bottom_sheet.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/utilities.dart';

class MapInfoSheet extends StatefulWidget {
  const MapInfoSheet({super.key});

  @override
  State<MapInfoSheet> createState() => _MapInfoSheetState();
}

class _MapInfoSheetState extends State<MapInfoSheet> {
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
              (woAuto.carMarkers.isNotEmpty ||
                  woAuto.friendCarMarkers.isNotEmpty))
            FloatingActionButton(
              tooltip: t.info_sheet.parkings,
              onPressed: (woAuto.carMarkers.isNotEmpty ||
                      woAuto.friendCarMarkers.isNotEmpty)
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
          FloatingActionButton.extended(
            onPressed: () async {
              LatLng? pos = woAuto.currentSelectedPosition.value;
              if (pos == null) {
                if (woAuto.hasLocationPermission.value) {
                  pos = woAuto.currentPosition.value.target;
                } else {
                  var action = await Get.dialog<String>(
                    AlertDialog(
                      title: Text(t.dialog.maps.no_location.title),
                      content: Text(t.dialog.maps.no_location.subtitle),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                          onPressed: () => pop(result: 'map'),
                          child: Text(t.dialog.maps.no_location.select_on_map),
                        ),
                        OutlinedButton(
                          onPressed: () => pop(result: 'enable'),
                          child:
                              Text(t.dialog.maps.no_location.enable_location),
                        ),
                      ],
                    ),
                    name: 'Kein Standort',
                  );

                  if (action == 'enable') {
                    await woAuto.handleUserLocationRequest();
                    if (woAuto.hasLocationPermission.value) {
                      pos = woAuto.currentPosition.value.target;
                    } else {
                      return;
                    }
                  } else {
                    return;
                  }
                }
              }

              await woAuto.onNewParking(pos);
              woAuto.tempMarkers
                  .removeWhere((element) => element.markerId.value == 'temp');
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
              if (!woAuto.hasLocationPermission.value) {
                await woAuto.handleUserLocationRequest();
              } else {
                try {
                  Position pos = await Geolocator.getCurrentPosition();
                  woAuto.currentPosition.value = CameraPosition(
                    target: LatLng(pos.latitude, pos.longitude),
                    zoom: CAM_ZOOM,
                  );
                } catch (_) {}
              }
              if (woAuto.hasLocationPermission.value &&
                  woAuto.mapController.value != null) {
                woAuto.mapController.value!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    woAuto.currentPosition.value,
                  ),
                );
              }
            },
            tooltip: t.info_sheet.current_position,
            child: Icon(
              woAuto.hasLocationPermission.value
                  ? Icons.location_searching_outlined
                  : Icons.location_disabled_outlined,
              color: woAuto.hasLocationPermission.value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
