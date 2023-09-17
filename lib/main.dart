import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
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
    // if (!isIOS()) {
    //   return GetCupertinoApp(
    //     home: woAuto.welcome.value ? const Intro() : const IOSHome(),
    //   );
    // }
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          );
        }
        return Obx(
          () {
            woAuto.dayColorScheme.value = lightColorScheme;
            woAuto.nightColorScheme.value = darkColorScheme;
            return GetMaterialApp(
              title: t.constants.app_name,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: lightColorScheme,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: darkColorScheme,
              ),
              themeMode: getThemeMode(woAuto.themeMode.value),
              home: woAuto.welcome.value ? const Intro() : const Home(),
              logWriterCallback: (text, {isError = false}) {
                if (isError == true) {
                  logMessage(text, tag: 'ERROR');
                } else {
                  logMessage(text, tag: 'INFO');
                }
              },
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
            );
          },
        );
      },
    );
  }
}
