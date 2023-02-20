import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: getBackgroundColor(context),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const GMap(),
            if (woAuto.currentIndex.value == 0) ...[
              const TopHeader(),
            ],
            if (woAuto.currentIndex.value == 1) ...[
              const History(),
            ],
            if (woAuto.currentIndex.value == 2) ...[
              const Settings(),
            ]
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: woAuto.currentIndex.value == 0,
          child: const MapInfoSheet(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: woAuto.currentIndex.value,
          onDestinationSelected: (index) {
            woAuto.currentIndex.value = index;
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.background,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              label: 'Karte',
              tooltip: 'Karte',
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: 'Historie',
              tooltip: 'Historie',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Einstellungen',
              tooltip: 'Einstellungen',
            ),
          ],
        ),
      ),
    );
  }
}
