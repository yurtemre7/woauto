import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
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
import 'package:woauto/utils/utilities.dart';

class CarBottomSheet extends StatefulWidget {
  const CarBottomSheet({super.key});

  @override
  State<CarBottomSheet> createState() => _CarBottomSheetState();
}

class _CarBottomSheetState extends State<CarBottomSheet> with TickerProviderStateMixin {
  final WoAutoServer woAutoServer = Get.find();

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
                    var friendsParkingList = woAuto.friendPositions.toList();
                    // var friendsCount = friendsParkingList.length;

                    var myParking = carParkingList.where((element) => element.mine).toList();
                    var myPos = woAuto.currentPosition.value.target;
                    var myPositonPark = CarPark(
                      uuid: 'me',
                      mine: true,
                      name: t.car_bottom_sheet.you.title,
                      latitude: myPos.latitude,
                      longitude: myPos.longitude,
                      adresse: t.car_bottom_sheet.you.address,
                    );
                    myParking.add(myPositonPark);
                    var otherParking =
                        friendsParkingList.where((element) => !element.mine).toList();
                    otherParking.addAll(woAuto.friendCarPositions);

                    return Column(
                      children: [
                        if (carParkingList.isNotEmpty || otherParking.isNotEmpty) ...[
                          // 15.h,
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
                          ...myParking.map(
                            (park) => buildParkTile(park),
                          ),
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
                          ...otherParking.map(
                            (park) => buildParkTile(park),
                          ),
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

  Widget parkHeader(Iterable<CarPark> myParking) {
    return Row(
      children: [
        Text(
          t.car_bottom_sheet.you.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget sharedParkHeader(Iterable<CarPark> otherParking) {
    return Row(
      children: [
        Text(
          t.car_bottom_sheet.friends.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget buildParkTile(CarPark park) {
    return ListTile(
      title: Text(
        '${park.name} - ${woAuto.getDistanceString(park.latLng)}',
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
              woAuto.currentSelectedPosition.value = park.latLng;
              woAuto.currentSelectedCarPark.value = park;
            case 3:
              woAuto.carParkings.removeWhere((element) => element.uuid == park.uuid);
              woAuto.carParkings.refresh();
              woAutoServer.deleteUserParkingLocations();

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
            if (park.mine && park.uuid != 'me')
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
        woAuto.currentSelectedPosition.value = park.latLng;
        woAuto.currentSelectedCarPark.value = park;
        pop();
      },
    );
  }
}
