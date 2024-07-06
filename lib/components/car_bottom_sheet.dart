import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/components/text_icon.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';

class CarBottomSheet extends StatefulWidget {
  const CarBottomSheet({super.key});

  @override
  State<CarBottomSheet> createState() => _CarBottomSheetState();
}

class _CarBottomSheetState extends State<CarBottomSheet> with TickerProviderStateMixin {
  final woAutoServer = Get.find<WoAutoServer>();

  late AnimationController _controller;
  late AnimationController _controllerOthers;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1.seconds);
    _controllerOthers = AnimationController(vsync: this, duration: 1.seconds);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerOthers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // border: Border.all(
        //   color: Colors.grey.withOpacity(0.3),
        // ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    var carParkingList = woAuto.carParkings.toList();

                    var myParking = carParkingList.where((element) => element.mine);
                    var otherParking = carParkingList.where((element) => !element.mine);

                    return Column(
                      children: [
                        if (carParkingList.isNotEmpty) ...[
                          const SizedBox(height: 15),
                          parkHeader(myParking),
                          if (myParking.isEmpty)
                            Container(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Text(
                                t.car_bottom_sheet.empty.parkings,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ...myParking
                              .map(
                                (park) => buildParkTile(park),
                              )
                              .toList(),
                          const Div(),
                          8.h,
                          sharedParkHeader(otherParking),
                          if (otherParking.isEmpty)
                            Container(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Text(
                                t.car_bottom_sheet.empty.shared_parkings,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ...otherParking
                              .map(
                                (park) => buildParkTile(park),
                              )
                              .toList(),
                        ],
                        const Div(),
                        TextButton.icon(
                          icon: const Icon(Icons.question_mark_outlined),
                          label: Text(
                            t.car_bottom_sheet.distance_calculation.title,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.snackbar(
                              t.snackbar.distance_calculation.title,
                              t.snackbar.distance_calculation.subtitle,
                              snackPosition: SnackPosition.TOP,
                              titleText: Text(
                                t.snackbar.distance_calculation.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              messageText: Column(
                                children: [
                                  Text(
                                    t.snackbar.distance_calculation.subtitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                  16.h,
                                  Text(
                                    t.snackbar.distance_calculation.subsubtitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              borderRadius: 12,
                              margin: const EdgeInsets.all(20),
                              duration: 10.seconds,
                              onTap: (snack) {
                                launchUrl(
                                  Uri.parse(
                                    'https://en.wikipedia.org/wiki/Haversine_formula',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              colorText: Theme.of(context).colorScheme.onSurface,
                            );
                          },
                        ),
                        15.h,
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row parkHeader(Iterable<CarPark> myParking) {
    return Row(
      children: [
        Text(
          t.car_bottom_sheet.parkings.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        if (myParking.isNotEmpty)
          TextButton.icon(
            onPressed: () async {
              _controller.forward().whenComplete(() => _controller.reset());

              for (var element in myParking) {
                if (element.sharing) {
                  await woAutoServer.updateLocation(park: element);
                }
              }
            },
            icon: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: const Icon(Icons.refresh),
            ),
            label: Text(t.constants.update),
          ),
      ],
    );
  }

  Row sharedParkHeader(Iterable<CarPark> otherParking) {
    return Row(
      children: [
        Text(
          t.car_bottom_sheet.shared_parkings.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        if (otherParking.isNotEmpty)
          TextButton.icon(
            onPressed: () async {
              _controllerOthers.forward().whenComplete(() => _controllerOthers.reset());
              for (var element in otherParking) {
                if (element.sharing) {
                  var loc = await woAutoServer.getLocation(id: element.uuid, view: element.viewKey);
                  if (loc == null) {
                    logMessage(
                      'Couldn\'t fetch location for ${element.name} (${element.uuid})',
                    );
                    // remove from sync list
                    woAuto.carParkings.removeWhere((e) => e.uuid == element.uuid);
                    woAuto.carParkings.refresh();
                    continue;
                  }
                  logMessage(
                    'Adding fetched location for ${element.name} (${element.uuid})',
                  );
                  woAuto.addAnotherCarPark(
                    newPosition: LatLng(
                      double.parse(loc.lat),
                      double.parse(loc.long),
                    ),
                    uuid: element.uuid,
                    view: loc.view,
                  );
                }
              }
            },
            icon: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controllerOthers),
              child: const Icon(Icons.refresh),
            ),
            label: Text(t.constants.update),
          ),
      ],
    );
  }

  ListTile buildParkTile(CarPark park) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        icon: Icon(
          park.sharing ? Icons.sync_sharp : Icons.sync_disabled_sharp,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: !park.sharing
            ? () async {
                var res = await Get.dialog(
                  AlertDialog(
                    title: Text(t.dialog.car_bottom_sheet.sync.title),
                    content: Text(
                      t.dialog.car_bottom_sheet.sync.subtitle,
                    ),
                    actions: [
                      TextButton(
                        child: Text(t.dialog.no),
                        onPressed: () => Get.back(result: false),
                      ),
                      OutlinedButton(
                        child: Text(t.dialog.car_bottom_sheet.sync.action_1),
                        onPressed: () async {
                          int until = DateTime.now().add(30.days).millisecondsSinceEpoch;
                          var acc = await woAutoServer.createLocation(park, until.toString());
                          if (acc == null) {
                            Get.back(result: false);
                            if (!mounted) return;
                            Get.snackbar(
                              t.constants.error,
                              t.constants.error_description,
                              snackPosition: SnackPosition.TOP,
                              titleText: Text(
                                t.constants.error,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              messageText: Text(
                                t.constants.error_description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              borderRadius: 12,
                              margin: const EdgeInsets.all(20),
                              duration: 10.seconds,
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              colorText: Theme.of(context).colorScheme.onSurface,
                            );
                            return;
                          }

                          park.sharing = true;
                          park.viewKey = acc.viewKey;
                          park.editKey = acc.editKey;
                          park.until = until;
                          woAuto.save();

                          Get.back(result: true);
                          setState(() {});
                        },
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  name: 'Parkplatz synchronisieren',
                );

                if (res == null || res == false) {
                  return;
                }

                if (!mounted) return;
                _showSyncDialog(park);
              }
            : () async {
                _showSyncDialog(park);
              },
      ),
      title: Text(
        '${park.name} - ${woAuto.getCarParkDistance(park)} m',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text(
        park.adresse ?? t.constants.default_address,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      trailing: PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        onSelected: (value) {
          switch (value) {
            case 0:
              MapsLauncher.launchCoordinates(
                park.latitude,
                park.longitude,
              );
            case 1:
              var uri = Uri.https(
                'www.google.com',
                '/maps/search/',
                {
                  'api': '1',
                  'query': '${park.latitude},${park.longitude}',
                },
              );
              Share.share(uri.toString());
            case 2:
              GoogleMapController controller = woAuto.mapController.value!;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: park.latLng,
                    zoom: CAM_ZOOM,
                  ),
                ),
              );
            case 3:
              if (park.sharing) {
                woAutoServer.deleteLocationAccount(park: park);
              }
              woAuto.carParkings.removeWhere((element) => element.uuid == park.uuid);
              woAuto.carParkings.refresh();

              flutterLocalNotificationsPlugin.cancelAll();
              woAuto.save();
          }
          pop();
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 0,
              child: TextIcon(
                icon: Icon(
                  Icons.map_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(
                  t.car_bottom_sheet.menu.open_park_in_maps,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: TextIcon(
                icon: Icon(
                  Icons.share_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(
                  t.car_bottom_sheet.menu.share_park,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: TextIcon(
                icon: Icon(
                  Icons.navigation_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(
                  t.car_bottom_sheet.menu.to_park,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: TextIcon(
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  t.car_bottom_sheet.menu.delete_park,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
          ];
        },
      ),
      onTap: () {
        GoogleMapController controller = woAuto.mapController.value!;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: park.latLng,
              zoom: CAM_ZOOM,
            ),
          ),
        );
        pop();
      },
    );
  }

  _showSyncDialog(CarPark park) {
    Get.dialog(
      AlertDialog(
        title: Text(t.dialog.car_bottom_sheet.synced.title),
        content: Text(
          t.dialog.car_bottom_sheet.synced.subtitle,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(t.dialog.delete),
            onPressed: () async {
              woAutoServer.deleteLocationAccount(park: park);
              park.sharing = false;
              park.editKey = '';
              park.viewKey = '';
              park.until = null;
              woAuto.save();

              Get.back();
              setState(() {});
            },
          ),
          OutlinedButton(
            child: Text(t.dialog.share),
            onPressed: () async {
              pop();
              String website = 'https://yurtemre.de';
              String woLink =
                  '$website/sync?id=${Uri.encodeFull(park.uuid)}&view=${Uri.encodeFull(park.viewKey)}&name=${Uri.encodeFull(park.name)}';
              Get.dialog(
                AlertDialog(
                  title: Text(t.dialog.car_bottom_sheet.sharing.title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(t.dialog.car_bottom_sheet.sharing.subtitle),
                      5.h,
                      SizedBox(
                        height: 320,
                        width: Get.width,
                        child: QrImageView(
                          data: woLink,
                          size: 320,
                          gapless: false,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text(t.dialog.abort),
                      onPressed: () => Get.back(result: false),
                    ),
                    ElevatedButton(
                      child: Text(t.dialog.car_bottom_sheet.sharing.action_1),
                      onPressed: () async {
                        Share.share(
                          t.dialog.car_bottom_sheet.sharing.share_content(woLink: woLink),
                        );
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      name: 'Parkplatz synchronisiert Info',
    );
  }
}
