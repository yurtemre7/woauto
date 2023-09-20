import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/ios_components/ios_top_header.dart';
import 'package:woauto/main.dart';

class CupertinoMapInfoSheet extends StatefulWidget {
  const CupertinoMapInfoSheet({super.key});

  @override
  State<CupertinoMapInfoSheet> createState() => _CupertinoMapInfoSheetState();
}

class _CupertinoMapInfoSheetState extends State<CupertinoMapInfoSheet> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (woAuto.carMarkers.isEmpty)
            Container(
              width: kMinInteractiveDimensionCupertino,
            ),
          if (!woAuto.drivingMode.value && woAuto.carMarkers.isNotEmpty)
            Card(
              child: CupertinoButton(
                onPressed: woAuto.carMarkers.isNotEmpty
                    ? () {
                        Get.bottomSheet(
                          const CupertinoCarBottomSheet(),
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
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: CupertinoButton(
              pressedOpacity: 0.9,
              onPressed: () => woAuto.onNewParking(woAuto.currentPosition.value.target),
              child: Text(
                t.info_sheet.park_save,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              // tooltip: t.info_sheet.park_save,
              // icon: const Icon(Icons.local_parking_outlined),
            ),
          ),
          Card(
            child: CupertinoButton(
              onPressed: () async {
                GoogleMapController controller = woAuto.mapController.value!;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    woAuto.currentPosition.value,
                  ),
                );
              },
              child: Icon(
                Icons.location_searching_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
