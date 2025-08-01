import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:woauto/components/car_bottom_sheet.dart';
import 'package:woauto/components/g_map.dart';
import 'package:woauto/components/map_info_sheet.dart';
import 'package:woauto/components/top_header.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/providers/yrtmr.dart';
import 'package:woauto/screens/history.dart';
import 'package:woauto/screens/intro.dart';
import 'package:woauto/screens/me.dart';
import 'package:woauto/screens/settings.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';
import 'package:location/location.dart' as loc;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription? _sub;
  late Timer timer;
  StreamSubscription<Position>? positionStream;
  final WoAutoServer woAutoServer = Get.find();

  @override
  void initState() {
    super.initState();

    YrtmrDeeplinks.initYrtmrLinks();
    _sub = YrtmrDeeplinks.yrtmrLinksListener();

    Future.delayed(0.seconds, () async {
      if (woAuto.welcome.value) {
        if (!mounted) return;
        await Get.bottomSheet(
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: const Intro(),
          ),
          isDismissible: false,
        );
        await loadPositionData();
      }

      NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        logMessage('Notification launched app');
      }
    });

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) async {
      switch (shortcutType) {
        case 'action_save':
          await Future.delayed(3.seconds);
          woAuto.addCarPark(
            woAuto.currentPosition.value.target,
          );

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
          Get.snackbar(
            t.snackbar.locked.title,
            t.snackbar.locked.subtitle,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.theme.colorScheme.primary,
            duration: const Duration(seconds: 15),
            mainButton: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(t.snackbar.locked.action),
            ),
            backgroundColor: Get.theme.colorScheme.primaryContainer,
          );
        case 'action_parkings':
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }
          Get.bottomSheet(
            const CarBottomSheet(),
            settings: const RouteSettings(
              name: 'CarBottomSheet',
            ),
          );
      }
    });
    var shortCuts = [
      ShortcutItem(
        type: 'action_save',
        localizedTitle: t.home.quick_actions.action_save,
        icon: 'monochrome',
      ),
      ShortcutItem(
        type: 'action_parkings',
        localizedTitle: t.home.quick_actions.action_parkings,
        icon: 'monochrome',
      ),
    ];
    quickActions.setShortcutItems(shortCuts);
  }

  Future<void> loadPositionData() async {
    var location = loc.Location();

    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Get.dialog(
          AlertDialog(
            title: Text(t.dialog.maps.location_denied.title),
            content: Text(t.dialog.maps.location_denied.subtitle),
            actions: [
              TextButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                  pop();
                },
                child: Text(t.dialog.open_settings),
              ),
            ],
          ),
          name: 'Standort Berechtigung',
        );

        return loadPositionData();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Get.dialog(
        AlertDialog(
          title: Text(t.dialog.maps.location_denied.title),
          content: Text(t.dialog.maps.location_denied.subtitle),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
                pop();
              },
              child: Text(t.dialog.open_settings),
            ),
          ],
        ),
        name: 'Standort Berechtigung',
      );
      return loadPositionData();
    }

    late LocationSettings locationSettings;

    if (isAndroid()) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        forceLocationManager: true,
        intervalDuration: 500.milliseconds,
      );
    } else if (isIOS()) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        activityType: ActivityType.automotiveNavigation,
        pauseLocationUpdatesAutomatically: true,
        allowBackgroundLocationUpdates: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      );
    }

    timer = Timer.periodic(10.seconds, (t) async {
      var currentPosition = woAuto.currentPosition.value.target;

      if (woAutoServer.shareMyLastLiveLocation.value) {
        woAutoServer.setUserLocation(
          LatLng(
            currentPosition.latitude,
            currentPosition.longitude,
          ),
        );
      }
    });

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      if (!mounted || position == null) {
        return;
      }
      woAuto.currentPosition.value = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: CAM_ZOOM,
      );

      if (woAuto.drivingMode.value) {
        if (woAuto.mapController.value != null) {
          woAuto.currentPosition.value = CameraPosition(
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
            zoom: CAM_ZOOM,
            bearing: position.heading,
          );
          woAuto.mapController.value!.animateCamera(
            CameraUpdate.newCameraPosition(
              woAuto.currentPosition.value,
            ),
          );
        }
      }

      woAuto.currentVelocity.value = position.speed;

      if (!woAuto.drivingMode.value && woAuto.askForDrivingMode.value) {
        if (kDebugMode) return;
        // show dialog to ask the user if he wants to switch to driving mode, IF his velocity is > woAuto.drivingModeDetectionSpeed.value
        var kmh = ((double.tryParse(
                  woAuto.currentVelocity.value.toStringAsFixed(2),
                ) ??
                0) *
            3.6);

        if (kmh > woAuto.drivingModeDetectionSpeed.value) {
          if (woAuto.currentIndex.value == 0) {
            woAuto.askForDrivingMode.value = false;
            var result = await Get.dialog<bool?>(
              AlertDialog(
                title: Text(t.dialog.maps.driving_mode.title),
                content: Text(
                  t.dialog.maps.driving_mode.subtitle,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      pop(result: false);
                    },
                    child: Text(t.dialog.no),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      pop(result: true);
                    },
                    child: Text(t.dialog.yes),
                  ),
                ],
              ),
              name: 'Fahrmodus',
            );
            if (result != null && result) {
              woAuto.drivingMode.value = true;
            }
          }
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.surface,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _sub?.cancel();
    KeepScreenOn.turnOff();
    woAuto.mapController.value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (woAuto.currentIndex.value != 0) {
            woAuto.currentIndex.value = 0;
            return;
          }

          Get.dialog(
            AlertDialog(
              title: Text(t.dialog.leave_info.title),
              content: Text(t.dialog.leave_info.subtitle),
              actions: [
                TextButton(
                  child: Text(t.dialog.abort),
                  onPressed: () => Get.back(result: false),
                ),
                OutlinedButton(
                  child: Text(t.dialog.leave),
                  onPressed: () {
                    Get.back(result: true);
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            name: 'App verlassen',
          );
        },
        child: Scaffold(
          backgroundColor: getBackgroundColor(context),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              const GMap(),
              Visibility(
                visible: woAuto.currentIndex.value == 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: const TopHeader(),
              ),
              Visibility(
                visible:
                    woAuto.currentIndex.value == 0 && !woAuto.drivingMode.value,
                child: const Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: MapInfoSheet(),
                ),
              ),
              Visibility(
                visible:
                    woAuto.currentIndex.value == 0 && woAuto.drivingMode.value,
                child: Positioned(
                  bottom: isIOS() ? 32 : 16,
                  right: 16,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      woAuto.showTraffic.value = !woAuto.showTraffic.value;
                      setState(() {});
                    },
                    label: Text(
                      woAuto.showTraffic.value
                          ? t.maps.traffic.hide
                          : t.maps.traffic.show,
                    ),
                  ),
                ),
              ),
              if (woAuto.currentIndex.value == 1) ...[
                const Me(),
              ],
              if (woAuto.currentIndex.value == 2) ...[
                const History(),
              ],
              if (woAuto.currentIndex.value == 3) ...[
                const Settings(),
              ],
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: !woAuto.drivingMode.value,
            child: NavigationBar(
              elevation: 0,
              selectedIndex: woAuto.currentIndex.value,
              onDestinationSelected: (index) {
                woAuto.currentIndex.value = index;
                if (woAuto.drivingMode.value) {
                  KeepScreenOn.turnOn();
                } else {
                  KeepScreenOn.turnOff();
                }
                woAuto.tempMarkers.clear();
                woAuto.currentSelectedPosition.value = null;
                woAuto.currentSelectedCarPark.value = null;
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.map_outlined),
                  label: t.home.navigation_1,
                  tooltip: t.home.navigation_1,
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible:
                        DateTime.now().difference(woAuto.tuvUntil.value).abs() <
                                30.days ||
                            woAuto.tuvUntil.value
                                .difference(DateTime.now())
                                .isNegative ||
                            woAuto.kilometerStand.value.isEmpty ||
                            woAuto.kennzeichen.value.isEmpty ||
                            woAuto.carBaujahr.value.isEmpty,
                    child: const Icon(Icons.car_rental_outlined),
                  ),
                  label: t.home.navigation_2,
                  tooltip: t.home.navigation_2,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.history_outlined),
                  label: t.home.navigation_3,
                  tooltip: t.home.navigation_3,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  label: t.home.navigation_4,
                  tooltip: t.home.navigation_4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
