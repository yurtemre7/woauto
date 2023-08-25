import 'dart:developer';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:woauto/providers/woauto.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/screens/home.dart';
import 'package:woauto/screens/intro.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:woauto/utils/utilities.dart';

late WoAuto woAuto;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  woAuto = Get.put(await WoAuto.load());
  Get.put(WoAutoServer.load());
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  tz.initializeTimeZones();
  try {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings('monochrome'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) {
          log('onDidReceiveLocalNotification called');
        },
      ),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  } catch (e) {
    log('Couldn\'t create Notification Channel or Initialize Android Notification Settings: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if (!isIOS()) {
    //   return GetCupertinoApp(
    //     home: woAuto.welcome.value ? const Intro() : const IOSHome(),
    //   );
    // }
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return Obx(
          () {
            woAuto.dayColorScheme.value = lightDynamic ?? const ColorScheme.light();
            woAuto.nightColorScheme.value = darkDynamic ?? const ColorScheme.dark();
            return GetMaterialApp(
              title: 'WoAuto',
              theme: ThemeData(
                brightness: Brightness.light,
                useMaterial3: true,
                colorScheme: lightDynamic,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
                colorScheme: darkDynamic,
              ),
              themeMode: getThemeMode(woAuto.themeMode.value),
              home: woAuto.welcome.value ? const Intro() : const Home(),
              logWriterCallback: (text, {isError = false}) {
                if (isError == true) {
                  log(text, name: 'ERROR');
                } else {
                  log(text, name: 'INFO');
                }
              },
            );
          },
        );
      },
    );
  }

  getThemeMode(int themeMode) {
    switch (themeMode) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
