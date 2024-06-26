import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/utilities.dart';

class IOSSettings extends StatefulWidget {
  const IOSSettings({super.key});

  @override
  State<IOSSettings> createState() => _IOSSettingsState();
}

class _IOSSettingsState extends State<IOSSettings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          Obx(
            () {
              var themeMode = woAuto.themeMode.value;
              var themes = ['System', 'Light', 'Dark'];

              return CupertinoListTile(
                title: Text(
                  t.settings.theme.title,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(
                  t.settings.theme.subtitle,
                ),
                trailing: CupertinoButton(
                  child: Text(
                    themes[themeMode],
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Container(
                        height: context.height * 0.25,
                        color: getBackgroundColor(context),
                        child: CupertinoPicker(
                          itemExtent: 32,
                          children: themes.map((e) => Text(e)).toList(),
                          onSelectedItemChanged: (value) async {
                            woAuto.themeMode.value = value;

                            await woAuto.save();
                            if (!mounted) return;
                            Future.delayed(
                              500.milliseconds,
                              () {
                                // SystemChrome.setSystemUIOverlayStyle(
                                //   SystemUiOverlayStyle(
                                //     systemNavigationBarColor: value == 1
                                //         ? woAuto.dayColorScheme.value.background
                                //         : value == 2
                                //             ? woAuto.nightColorScheme.value.background
                                //             : Theme.of(context).colorScheme.background,
                                //   ),
                                // );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Obx(
            () {
              // var mapType = woAuto.mapType.value;
              // DropdownButton<MapType> dropdownButton = DropdownButton<MapType>(
              //   value: mapType,
              //   items: [
              //     DropdownMenuItem(
              //       value: MapType.normal,
              //       child: Text(t.settings.map_type.dropdown_1),
              //     ),
              //     DropdownMenuItem(
              //       value: MapType.satellite,
              //       child: Text(t.settings.map_type.dropdown_2),
              //     ),
              //     DropdownMenuItem(
              //       value: MapType.hybrid,
              //       child: Text(t.settings.map_type.dropdown_3),
              //     ),
              //     DropdownMenuItem(
              //       value: MapType.terrain,
              //       child: Text(t.settings.map_type.dropdown_4),
              //     ),
              //   ],
              //   onChanged: (v) async {
              //     woAuto.mapType.value = v!;
              //     // pop();
              //   },
              // );

              return CupertinoListTile(
                title: Text(
                  t.settings.map_type.title,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(
                  t.settings.map_type.subtitle,
                ),
                // trailing: dropdownButton,
              );
            },
          ),
          Obx(
            () => CupertinoListTile(
              title: Text(
                t.settings.traffic.title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              subtitle: Text(
                t.settings.traffic.subtitle,
              ),
              trailing: CupertinoSwitch(
                value: woAuto.showTraffic.value,
                onChanged: (v) async {
                  woAuto.showTraffic.value = v;
                  await woAuto.save();
                },
              ),
            ),
          ),
          Obx(
            () {
              // var time = woAuto.timePuffer.value;
              // DropdownButton<int> dropdownButton = DropdownButton<int>(
              //   value: time,
              //   items: [
              //     DropdownMenuItem(
              //       value: 5,
              //       child: Text(t.settings.park_ticket.dropdown_value(value: 5)),
              //     ),
              //     DropdownMenuItem(
              //       value: 10,
              //       child: Text(t.settings.park_ticket.dropdown_value(value: 10)),
              //     ),
              //     DropdownMenuItem(
              //       value: 15,
              //       child: Text(t.settings.park_ticket.dropdown_value(value: 15)),
              //     ),
              //     DropdownMenuItem(
              //       value: 20,
              //       child: Text(t.settings.park_ticket.dropdown_value(value: 20)),
              //     ),
              //     DropdownMenuItem(
              //       value: 25,
              //       child: Text(t.settings.park_ticket.dropdown_value(value: 25)),
              //     ),
              //     DropdownMenuItem(
              //       value: 30,
              //       child: Text(t.settings.park_ticket.dropdown_value(value: 30)),
              //     ),
              //   ],
              //   onChanged: (v) {
              //     woAuto.timePuffer.value = v!;
              //     woAuto.save();
              //     // pop();
              //   },
              // );

              return CupertinoListTile(
                title: Text(
                  t.settings.park_ticket.title,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(
                  t.settings.park_ticket.subtitle,
                ),
                // trailing: dropdownButton,
              );
            },
          ),
          Obx(
            () {
              // var speed = woAuto.drivingModeDetectionSpeed.value;
              // DropdownButton<int> dropdownButton = DropdownButton<int>(
              //   value: speed,
              //   items: [
              //     DropdownMenuItem(
              //       value: 20,
              //       child: Text(t.settings.driving_mode.dropdown_value(value: 20)),
              //     ),
              //     DropdownMenuItem(
              //       value: 25,
              //       child: Text(t.settings.driving_mode.dropdown_value(value: 25)),
              //     ),
              //     DropdownMenuItem(
              //       value: 30,
              //       child: Text(t.settings.driving_mode.dropdown_value(value: 30)),
              //     ),
              //     DropdownMenuItem(
              //       value: 35,
              //       child: Text(t.settings.driving_mode.dropdown_value(value: 35)),
              //     ),
              //     DropdownMenuItem(
              //       value: 40,
              //       child: Text(t.settings.driving_mode.dropdown_value(value: 40)),
              //     ),
              //   ],
              //   onChanged: (v) {
              //     woAuto.drivingModeDetectionSpeed.value = v!;
              //     woAuto.save();
              //     // pop();
              //   },
              // );

              return CupertinoListTile(
                title: Text(
                  t.settings.driving_mode.title,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(
                  t.settings.driving_mode.subtitle,
                ),
                // trailing: dropdownButton,
              );
            },
          ),
          Obx(
            () => CupertinoListTile(
              leading: Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                t.settings.app_info.title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              subtitle: Text(
                t.settings.app_info.subtitle(
                  appVersion: woAuto.appVersion,
                  buildNumber: woAuto.appBuildNumber,
                ),
              ),
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(t.dialog.app_info.title),
                    content: Text(
                      t.dialog.app_info.subtitle,
                    ),
                    actions: [
                      ElevatedButton(
                        child: Text(t.dialog.app_info.action_1),
                        onPressed: () {
                          launchUrl(
                            Uri.parse('https://github.com/yurtemre7/woauto'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),
                    ],
                  ),
                  name: 'App Info',
                );
              },
            ),
          ),
          CupertinoListTile(
            leading: Icon(
              Icons.volunteer_activism_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              t.settings.credits.title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Text(
              t.settings.credits.subtitle,
            ),
          ),
          CupertinoListTile(
            leading: Icon(
              Icons.share_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              t.settings.share.title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Text(
              t.settings.share.subtitle,
            ),
            onTap: () {
              Share.share(
                t.settings.share.share_content,
              );
            },
          ),
          CupertinoListTile(
            leading: Icon(
              Icons.feedback_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              t.settings.feedback.title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Text(t.settings.feedback.subtitle),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(t.dialog.feedback.title),
                  content: Text(
                    t.dialog.feedback.subtitle,
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text(t.dialog.feedback.action_1),
                      onPressed: () {
                        launchUrl(
                          Uri.parse('https://t.me/programmiererfreunde'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text(t.dialog.feedback.action_1),
                      onPressed: () {
                        launchUrl(
                          Uri.parse('https://t.me/emredev'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
                name: 'Feedback',
              );
            },
          ),
          CupertinoListTile(
            leading: Icon(
              Icons.gpp_good_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              t.settings.data_security.title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Text(t.settings.data_security.subtitle),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(t.dialog.data_security.title),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          t.dialog.data_security.content_1,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          t.dialog.data_security.content_2,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          t.dialog.data_security.content_3,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          t.dialog.data_security.content_4,
                        ),
                        const SizedBox(height: 5),
                        Text.rich(
                          TextSpan(
                            text: t.dialog.data_security.content_5,
                            children: [
                              TextSpan(
                                text: t.dialog.data_security.content_6,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: t.dialog.data_security.content_7,
                              ),
                              TextSpan(
                                text: t.dialog.data_security.content_8,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text(t.dialog.data_security.action_1),
                      onPressed: () {
                        launchUrl(
                          Uri.parse('https://www.yurtemre.de/impressum'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text(t.dialog.data_security.action_2),
                      onPressed: () {
                        launchUrl(
                          Uri.parse('https://www.yurtemre.de/datenschutz'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
                name: 'Datenschutz und Impressum',
              );
            },
          ),
          CupertinoListTile(
            leading: Icon(
              Icons.delete_forever_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              t.settings.app_data.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            subtitle: Text(t.settings.app_data.subtitle_ios),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(t.dialog.app_data.title),
                  content: Text(t.dialog.app_data.subtitle),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                      child: Text(t.dialog.delete),
                      onPressed: () async {
                        WoAutoServer woAutoServer = Get.find();
                        var parkings = woAuto.carParkings;
                        for (var parking in parkings) {
                          if (parking.sharing) {
                            woAutoServer.deleteLocationAccount(
                              park: parking,
                            );
                          }
                        }
                        // pop();
                        pop();
                        await woAuto.reset();
                      },
                    ),
                    OutlinedButton(
                      child: Text(t.dialog.abort),
                      onPressed: () {
                        pop();
                      },
                    ),
                  ],
                ),
                name: 'App-Daten löschen',
              );
            },
          ),
        ],
      ),
    );
  }
}
