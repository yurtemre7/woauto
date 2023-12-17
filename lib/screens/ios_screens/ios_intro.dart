import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class IOSIntro extends StatefulWidget {
  const IOSIntro({super.key});

  @override
  State<IOSIntro> createState() => _IntroState();
}

class _IntroState extends State<IOSIntro> {
  var tec = TextEditingController(text: '');
  var pageController = PageController();
  var pageIndex = 0.obs;
  final allowed = false.obs;
  final notifAllowed = false.obs;
  final showError = false.obs;

  @override
  void initState() {
    super.initState();
    Future.delayed(0.seconds, () async {
      var permission = await Location().hasPermission();
      allowed.value = permission == PermissionStatus.granted;
    });
  }

  @override
  void dispose() {
    tec.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: getBackgroundColor(context),
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            pageIndex.value == 0 ? t.intro.page_1.page_title : t.intro.page_2.page_title,
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: pageIndex.value == 0
                ? () => pageController.nextPage(duration: 500.milliseconds, curve: Curves.easeInOut)
                : () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!allowed.value) {
                      showError.value = true;
                      return;
                    }
                    showError.value = false;

                    woAuto.subText.value = tec.text.trim();
                    if (woAuto.subText.value.isEmpty) {
                      woAuto.subText.value = t.constants.default_park_title;
                    }

                    woAuto.welcome.value = false;

                    await woAuto.save();
                    pop();
                  },
            child: pageIndex.value == 0
                ? Text(t.intro.page_1.action_1)
                : Text(t.intro.page_2.action_1),
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: PageView(
              controller: pageController,
              onPageChanged: (v) => pageIndex.value = v,
              children: [
                ListView(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 16,
                    right: 16,
                    bottom: 10,
                  ),
                  children: [
                    Text(
                      t.intro.page_1.title,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    15.h,
                    Text(
                      t.intro.page_1.content_1,
                    ),
                    15.h,
                    Text(
                      t.intro.page_1.content_2,
                    ),
                    15.h,
                    Text(
                      t.intro.page_1.content_3,
                    ),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 16,
                    right: 16,
                    bottom: 10,
                  ),
                  children: [
                    Text(
                      t.intro.page_2.parking_title,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    12.h,
                    CupertinoTextField(
                      controller: tec,
                      maxLength: 30,
                      autocorrect: false,
                      placeholder: t.intro.page_2.parking_hint,
                    ),
                    12.h,
                    Text(
                      t.intro.page_2.parking_content,
                      style: const TextStyle(),
                    ),
                    8.h,
                    const Div(),
                    8.h,
                    Text(
                      t.intro.page_2.theme_title,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    12.h,
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
                                builder: (context) => SizedBox(
                                  height: context.height * 0.25,
                                  child: CupertinoPicker(
                                    itemExtent: 32,
                                    children: themes.map((e) => Text(e)).toList(),
                                    onSelectedItemChanged: (value) async {
                                      woAuto.themeMode.value = value;

                                      await woAuto.setMapStyle(
                                        brightness: value == 1
                                            ? Brightness.light
                                            : value == 2
                                                ? Brightness.dark
                                                : null,
                                      );
                                      await woAuto.save();
                                      if (!mounted) return;
                                      Future.delayed(
                                        500.milliseconds,
                                        () {
                                          SystemChrome.setSystemUIOverlayStyle(
                                            SystemUiOverlayStyle(
                                              systemNavigationBarColor: value == 1
                                                  ? woAuto.dayColorScheme.value.background
                                                  : value == 2
                                                      ? woAuto.nightColorScheme.value.background
                                                      : Theme.of(context).colorScheme.background,
                                            ),
                                          );
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
                    12.h,
                    Text(
                      t.intro.page_2.theme_content,
                    ),
                    8.h,
                    const Div(),
                    8.h,
                    Text(
                      t.intro.page_2.location_title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    8.h,
                    Text(
                      t.intro.page_2.location_content,
                    ),
                    16.h,
                    Obx(
                      () => CupertinoListTile(
                        title: Text(t.intro.page_2.location_checkbox),
                        subtitle: showError.value
                            ? Text(
                                t.intro.page_2.location_checkbox_error,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              )
                            : null,
                        trailing: CupertinoCheckbox(
                          // contentPadding: EdgeInsets.zero,

                          value: allowed.value,
                          onChanged: (val) async {
                            if (val == null) return;

                            if (!val) {
                              allowed.value = val;
                              return;
                            }
                            var v = await Location().requestPermission();
                            allowed.value = v == PermissionStatus.granted;
                            showError.value = !allowed.value;
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => CupertinoListTile(
                        title: Text(t.intro.page_2.notification_checkbox),
                        trailing: CupertinoCheckbox(
                          value: notifAllowed.value,
                          onChanged: (val) async {
                            if (val == null) return;

                            if (!val) {
                              notifAllowed.value = val;
                              return;
                            }
                            if (isIOS()) {
                              var result = await flutterLocalNotificationsPlugin
                                  .resolvePlatformSpecificImplementation<
                                      IOSFlutterLocalNotificationsPlugin>()
                                  ?.requestPermissions(
                                    alert: true,
                                    badge: true,
                                    sound: true,
                                  );
                              notifAllowed.value = result ?? false;
                              return;
                            }
                            var v = await flutterLocalNotificationsPlugin
                                .resolvePlatformSpecificImplementation<
                                    AndroidFlutterLocalNotificationsPlugin>()
                                ?.requestNotificationsPermission();
                            notifAllowed.value = v ?? false;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
