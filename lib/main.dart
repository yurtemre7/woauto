import 'dart:developer';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woauto/screens/home.dart';
import 'package:woauto/providers/woauto.dart';
import 'package:woauto/screens/intro.dart';

late WoAuto woAuto;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  woAuto = Get.put(await WoAuto.load());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return Obx(
          () => GetMaterialApp(
            title: 'WoAuto',
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: woAuto.android13Theme.value,
              colorScheme: lightDynamic,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: woAuto.android13Theme.value,
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
          ),
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
