import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:woauto/components/g_map.dart';
import 'package:woauto/components/map_info_sheet.dart';

import 'package:woauto/components/top_header.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/yrtmr.dart';
import 'package:woauto/screens/history.dart';
import 'package:woauto/screens/settings.dart';
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
        log('Notification launched app');
      }
    });
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
                visible: woAuto.currentIndex.value == 1,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: const DrivingHeader(),
              ),
              Visibility(
                visible: woAuto.currentIndex.value == 0,
                child: const Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: MapInfoSheet(),
                ),
              ),
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
              if (index == 1) {
                KeepScreenOn.turnOn();
              } else {
                KeepScreenOn.turnOff();
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: 'Karte',
                tooltip: 'Karte',
              ),
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: 'Driving',
                tooltip: 'Karte',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined),
                label: 'Historie',
                tooltip: 'Historie',
              ),
              NavigationDestination(
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
