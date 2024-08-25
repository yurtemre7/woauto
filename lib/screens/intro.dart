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

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var tec = TextEditingController(text: '');
  var pageController = PageController();
  var pageIndex = 0.obs;
  final allowed = false.obs;
  final notifAllowed = false.obs;
  final notifExactAllowed = false.obs;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getBackgroundColor(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: PageView(
              controller: pageController,
              onPageChanged: (v) => pageIndex.value = v,
              children: [
                Scrollbar(
                  child: ListView(
                    children: [
                      Text(
                        t.intro.page_1.page_title,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.intro.page_1.title,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            5.h,
                            const Div(),
                            5.h,
                            Text(
                              t.intro.page_1.content_1,
                            ),
                            5.h,
                            const Div(),
                            5.h,
                            Text(
                              t.intro.page_1.content_2,
                            ),
                            5.h,
                            const Div(),
                            5.h,
                            Text(
                              t.intro.page_1.content_3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.only(right: 8),
                    children: [
                      Text(
                        t.intro.page_2.page_title,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t.intro.page_2.parking_title,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Div(),
                            Text(
                              t.intro.page_2.parking_content,
                              style: const TextStyle(),
                            ),
                            16.h,
                            TextFormField(
                              controller: tec,
                              maxLength: 30,
                              autocorrect: false,
                              decoration: InputDecoration(
                                labelText: t.intro.page_2.parking_hint,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            16.h,
                            Text(
                              t.intro.page_2.theme_title,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Div(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    t.intro.page_2.theme_content,
                                  ),
                                ),
                                15.h,
                                Obx(
                                  () {
                                    var themeMode = woAuto.themeMode.value;
                                    DropdownButton<int> dropdownButton = DropdownButton<int>(
                                      value: themeMode,
                                      items: [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text(t.settings.theme.dropdown_1),
                                        ),
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text(t.settings.theme.dropdown_2),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text(t.settings.theme.dropdown_3),
                                        ),
                                      ],
                                      onChanged: (v) async {
                                        woAuto.themeMode.value = v!;

                                        await woAuto.save();
                                        woAuto.setTheme();
                                        if (!mounted) return;
                                        Future.delayed(500.milliseconds, () {
                                          if (!context.mounted) return;
                                          SystemChrome.setSystemUIOverlayStyle(
                                            SystemUiOverlayStyle(
                                              systemNavigationBarColor:
                                                  Theme.of(context).colorScheme.surface,
                                            ),
                                          );
                                        });
                                      },
                                    );

                                    return dropdownButton;
                                  },
                                ),
                              ],
                            ),
                            16.h,
                            Text(
                              t.intro.page_2.location_title,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Div(),
                            Text(
                              t.intro.page_2.location_content,
                            ),
                            16.h,
                            Obx(
                              () => CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(t.intro.page_2.location_checkbox),
                                subtitle: showError.value
                                    ? Text(
                                        t.intro.page_2.location_checkbox_error,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.error,
                                        ),
                                      )
                                    : null,
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
                            Obx(
                              () => CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(t.intro.page_2.notification_checkbox),
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
                            if (isAndroid())
                              Obx(
                                () => CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(t.intro.page_2.exact_notification_checkbox),
                                  subtitle: Text(t.intro.page_2.exact_notification_description),
                                  value: notifExactAllowed.value,
                                  onChanged: (val) async {
                                    if (val == null) return;

                                    if (!val) {
                                      notifExactAllowed.value = val;
                                      return;
                                    }

                                    var v = await flutterLocalNotificationsPlugin
                                        .resolvePlatformSpecificImplementation<
                                            AndroidFlutterLocalNotificationsPlugin>()
                                        ?.requestExactAlarmsPermission();

                                    notifExactAllowed.value = v ?? false;
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: pageIndex.value == 0
                      ? () => pageController.nextPage(
                          duration: 500.milliseconds, curve: Curves.easeInOut)
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
                  label: pageIndex.value == 0
                      ? Text(t.intro.page_1.action_1)
                      : Text(t.intro.page_2.action_1),
                  icon: pageIndex.value == 0
                      ? const Icon(Icons.arrow_right_alt_outlined)
                      : const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
