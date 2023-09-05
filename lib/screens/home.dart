import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:woauto/components/g_map.dart';
import 'package:woauto/components/map_info_sheet.dart';
import 'package:woauto/components/top_header.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/yrtmr.dart';
import 'package:woauto/screens/history.dart';
import 'package:woauto/screens/my_car.dart';
import 'package:woauto/screens/settings.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    YrtmrDeeplinks.initYrtmrLinks();
    _sub = YrtmrDeeplinks.yrtmrLinksListener();

    Future.delayed(0.seconds, () async {
      NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
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
            'Hast du dein Auto abgeschlossen?',
            'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.theme.colorScheme.primary,
            duration: const Duration(seconds: 15),
            mainButton: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Ja, habe ich.'),
            ),
            backgroundColor: Get.theme.colorScheme.primaryContainer,
          );
          break;
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
          break;
      }
    });
    var shortCuts = [
      const ShortcutItem(
        type: 'action_save',
        localizedTitle: 'Parkplatz speichern',
        icon: 'monochrome',
      ),
      const ShortcutItem(
        type: 'action_parkings',
        localizedTitle: 'Parkplätze ansehen',
        icon: 'monochrome',
      )
    ];
    quickActions.setShortcutItems(shortCuts);
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
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
      () => WillPopScope(
        onWillPop: () async {
          if (woAuto.currentIndex.value != 0) {
            woAuto.currentIndex.value = 0;
            return false;
          }

          return await Get.dialog(
            AlertDialog(
              title: const Text('App verlassen'),
              content: const Text('Möchtest du die App verlassen?'),
              actions: [
                TextButton(
                  child: const Text('ABBRECHEN'),
                  onPressed: () => Get.back(result: false),
                ),
                ElevatedButton(
                  child: const Text('VERLASSEN'),
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
                visible: woAuto.currentIndex.value == 0 && !woAuto.drivingMode.value,
                child: const Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: MapInfoSheet(),
                ),
              ),
              if (woAuto.currentIndex.value == 1) ...[
                const MyCar(),
              ],
              if (woAuto.currentIndex.value == 2) ...[
                const History(),
              ],
              if (woAuto.currentIndex.value == 3) ...[
                const Settings(),
              ]
            ],
          ),
          bottomNavigationBar: NavigationBar(
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
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: 'Karte',
                tooltip: 'Karte',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible:
                      DateTime.now().difference(woAuto.tuvUntil.value).abs() < 30.days ||
                          woAuto.tuvUntil.value.difference(DateTime.now()).isNegative ||
                          woAuto.kilometerStand.value.isEmpty ||
                          woAuto.kennzeichen.value.isEmpty ||
                          woAuto.carBaujahr.value.isEmpty,
                  child: const Icon(Icons.car_rental_outlined),
                ),
                label: 'Mein Auto',
                tooltip: 'Mein Auto',
              ),
              const NavigationDestination(
                icon: Icon(Icons.history_outlined),
                label: 'Historie',
                tooltip: 'Historie',
              ),
              const NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                label: 'Einstellungen',
                tooltip: 'Einstellungen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
