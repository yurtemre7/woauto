import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woauto/components/g_map.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/ios_components/ios_map_info_sheet.dart';
import 'package:woauto/ios_components/ios_my_car.dart';
import 'package:woauto/ios_components/ios_settings.dart';
import 'package:woauto/ios_components/ios_top_header.dart';
import 'package:woauto/main.dart';

class IOSHome extends StatefulWidget {
  const IOSHome({super.key});

  @override
  State<IOSHome> createState() => _IOSHomeState();
}

class _IOSHomeState extends State<IOSHome> {
  var controller = CupertinoTabController(initialIndex: woAuto.currentIndex.value);
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: controller,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.map),
            label: t.home.navigation_1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.car),
            label: t.home.navigation_2,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.clock),
            label: t.home.navigation_3,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.gear),
            label: t.home.navigation_4,
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return Obx(
                  () => Stack(
                    children: [
                      const GMap(),
                      const CupertinoTopHeader(),
                      Visibility(
                        visible: !woAuto.drivingMode.value,
                        child: const Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: SafeArea(child: CupertinoMapInfoSheet()),
                        ),
                      ),
                      Visibility(
                        visible: woAuto.drivingMode.value,
                        child: Positioned(
                          bottom: 16,
                          right: 16,
                          child: SafeArea(
                            child: Obx(
                              () => Card(
                                child: CupertinoButton(
                                  onPressed: () {
                                    woAuto.showTraffic.value = !woAuto.showTraffic.value;
                                    setState(() {});
                                  },
                                  child: Text(
                                    woAuto.showTraffic.value
                                        ? t.maps.traffic.hide
                                        : t.maps.traffic.show,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              case 1:
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(t.my_car.title),
                  ),
                  child: const SafeArea(child: CupertinoMyCar()),
                );
              case 3:
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(t.settings.title),
                  ),
                  child: const SafeArea(
                    child: IOSSettings(),
                  ),
                );
            }
            return Center(
              child: Text('Content of tab $index'),
            );
          },
        );
      },
    );
  }
}
