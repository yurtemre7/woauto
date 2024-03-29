import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';

class TopHeader extends StatefulWidget {
  const TopHeader({super.key});

  @override
  State<TopHeader> createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.constants.app_name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.primary,
                      ),
                    ),
                    Obx(
                      () {
                        var kmh =
                            ((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ??
                                    0) *
                                3.6);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (woAuto.drivingMode.value) ...[
                              if (woAuto.currentVelocity.value >= 0.0)
                                Row(
                                  children: [
                                    Container(
                                      // ! such a stupid hack, cuz the package is
                                      // ! not centering it properly xD
                                      margin: const EdgeInsets.only(bottom: 6),
                                      child: AnimatedDigitWidget(
                                        boxDecoration: const BoxDecoration(),
                                        value: kmh,
                                        fractionDigits: 1,
                                        textStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: context.theme.colorScheme.primary,
                                        ),
                                        loop: false,
                                      ),
                                    ),
                                    Text(
                                      ' km/h',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: context.theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              8.w,
                            ],
                            IconButton(
                              tooltip: t.top_header.driving_mode_tooltip,
                              style: IconButton.styleFrom(
                                foregroundColor: context.theme.colorScheme.primary,
                                disabledForegroundColor: Colors.grey.withOpacity(0.3),
                              ),
                              onPressed: () {
                                woAuto.drivingMode.toggle();
                                woAuto.currentSelectedCarPark.value = null;
                                woAuto.currentSelectedPosition.value = null;
                              },
                              icon: Icon(
                                woAuto.drivingMode.value
                                    ? Icons.directions_car
                                    : Icons.directions_walk,
                              ),
                              iconSize: 30,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (woAuto.currentSelectedPosition.value != null) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // woAuto.showCarParkDialog(park);
                        if (woAuto.currentSelectedCarPark.value != null)
                          ChoiceChip(
                            label: Text(
                              woAuto.currentSelectedCarPark.value!.name,
                            ),
                            selected: false,
                            showCheckmark: false,
                            avatar: Icon(
                              Icons.info_outline,
                              color: context.theme.colorScheme.primary,
                            ),
                            onSelected: (value) {
                              woAuto.showCarParkDialog(woAuto.currentSelectedCarPark.value!);
                            },
                          ),
                        8.w,
                        ChoiceChip(
                          label: Text(
                            '${woAuto.getDistance(woAuto.currentSelectedPosition.value!)} m',
                          ),
                          selected: false,
                          showCheckmark: false,
                          avatar: Icon(
                            Icons.info_outline,
                            color: context.theme.colorScheme.primary,
                          ),
                          onSelected: (value) {
                            Get.dialog(
                              AlertDialog(
                                title: const Text(
                                  'Entfernung',
                                ),
                                content: Text(
                                  '${woAuto.getDistance(woAuto.currentSelectedPosition.value!)} m.\n\nWas hast du denn noch erwartet?!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'OK',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        8.w,
                        ChoiceChip(
                          label: const Text(
                            'Navigieren',
                          ),
                          selected: false,
                          onSelected: (value) {
                            var pos = woAuto.currentSelectedPosition.value!;
                            MapsLauncher.launchCoordinates(
                              pos.latitude,
                              pos.longitude,
                            );
                          },
                          showCheckmark: false,
                          avatar: Icon(
                            Icons.navigation_outlined,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return 0.h;
            }),
          ],
        ),
      ),
    );
  }
}
