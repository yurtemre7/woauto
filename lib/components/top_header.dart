import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woauto/main.dart';
import 'package:woauto/screens/settings.dart';

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
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/icon.png',
                        fit: BoxFit.contain,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const Text(
                      'WoAuto',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        // Go to settings
                        Get.bottomSheet(const Settings());
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (woAuto.currentVelocity.value >= 3.0) {
                return Text(
                  'Speed ${((double.tryParse(woAuto.currentVelocity.value.toStringAsFixed(2)) ?? 0) * 3.6).toStringAsFixed(1)} km/h',
                  style: const TextStyle(fontSize: 16.0),
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
