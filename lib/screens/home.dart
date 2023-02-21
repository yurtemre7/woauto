import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:woauto/components/g_map.dart';
import 'package:woauto/components/map_info_sheet.dart';

import 'package:woauto/components/top_header.dart';
import 'package:woauto/providers/woauto.dart';
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

  WoAuto get woAutoController => Get.find<WoAuto>();

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
            Visibility(
              visible: woAutoController.currentIndex.value == 0,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: const TopHeader(),
            ),
            if (woAutoController.currentIndex.value == 1) ...[
              const History(),
            ],
            if (woAutoController.currentIndex.value == 2) ...[
              const Settings(),
            ]
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: woAutoController.currentIndex.value == 0,
          child: const MapInfoSheet(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: woAutoController.currentIndex.value,
          onDestinationSelected: (index) {
            woAutoController.currentIndex.value = index;
            var snapPos = woAutoController.snappingSheetController.value.currentSnappingPosition;
            var offset = snapPos.grabbingContentOffset;
            if (offset > 0) {
              woAutoController.snappingSheetController.value.snapToPosition(
                resetPosition,
              );
            }
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
