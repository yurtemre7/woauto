import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/providers/woauto.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/screens/home.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:woauto/screens/intro.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';

late WoAuto woAuto;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
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
          logMessage('onDidReceiveLocalNotification called');
        },
      ),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  } catch (e) {
    logMessage(
        'Couldn\'t create Notification Channel or Initialize Android Notification Settings: $e');
  }
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GetMaterialApp(
          title: t.constants.app_name,
          themeMode: getThemeMode(woAuto.themeMode.value),
          theme: ThemeData(
            brightness: woAuto.themeMode.value == 0
                ? MediaQuery.of(context).platformBrightness
                : woAuto.themeMode.value == 1
                    ? Brightness.light
                    : Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(woAuto.appColor.value),
              brightness: woAuto.themeMode.value == 0
                  ? MediaQuery.of(context).platformBrightness
                  : woAuto.themeMode.value == 1
                      ? Brightness.light
                      : Brightness.dark,
            ),
            fontFamily: GoogleFonts.ptSansCaption().fontFamily,
          ),
          home: woAuto.welcome.value ? const Intro() : const Home(),
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        );
      },
    );
  }
}
