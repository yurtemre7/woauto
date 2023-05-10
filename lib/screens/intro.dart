import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:location/location.dart';
import 'package:woauto/components/div.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: IntroductionScreen(
          controlsPadding: const EdgeInsets.all(20),
          globalBackgroundColor: getBackgroundColor(context),
          pages: [
            PageViewModel(
              titleWidget: Text(
                'WoAuto',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              bodyWidget: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Willkommen bei WoAuto',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Div(),
                    SizedBox(height: 5),
                    Text(
                      'Mit der App wirst du nie wieder deinen Parkplatz vergessen.',
                    ),
                    SizedBox(height: 5),
                    Div(),
                    SizedBox(height: 5),
                    Text(
                      'Speichere in nur 2 Klicks deinen Parkplatz und du kannst ihn jederzeit wieder finden.',
                    ),
                  ],
                ),
              ),
            ),
            PageViewModel(
              titleWidget: Text(
                'App-Voreinstellungen',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              bodyWidget: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Parkplatz-Titel setzen',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Div(),
                    const Text(
                      'Setze dir einen coolen Parkplatz-Titel für dein Auto.',
                      style: TextStyle(),
                    ),
                    16.h,
                    TextFormField(
                      controller: tec,
                      maxLength: 30,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Mein Auto',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    16.h,
                    const Text(
                      'App-Theme einstellen',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Div(),
                    Row(
                      children: [
                        const Flexible(
                          child: Text(
                            'Entscheide selbst, ob du das Theme des Systems, das Light-Theme oder das Dark-Theme nutzen möchtest.',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Obx(
                          () {
                            var themeMode = woAuto.themeMode.value;
                            DropdownButton<int> dropdownButton = DropdownButton<int>(
                              value: themeMode,
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text('System'),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text('Hell'),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text('Dunkel'),
                                ),
                              ],
                              onChanged: (v) async {
                                woAuto.themeMode.value = v!;
                                await woAuto.save();
                              },
                            );

                            return dropdownButton;
                          },
                        ),
                      ],
                    ),
                    16.h,
                    const Text(
                      'Echtzeit-Standortabfragen erlauben',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Div(),
                    const Text(
                      'Erlaube der App, deinen Standort in Echtzeit während der App-Nutzung abzufragen. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.',
                    ),
                    16.h,
                    Obx(
                      () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Echtzeit-Standortabfragen'),
                        subtitle: showError.value
                            ? const Text(
                                'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.',
                                style: TextStyle(
                                  color: Colors.redAccent,
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
                        title: const Text('Benachrichtigungen erlauben (optional)'),
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
                              ?.requestPermission();
                          notifAllowed.value = v ?? false;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onDone: () async {
            if (!allowed.value) {
              showError.value = true;
              return;
            }
            showError.value = false;

            // set data aquired from intro
            woAuto.subText.value = tec.text.trim();
            if (woAuto.subText.value.isEmpty) {
              woAuto.subText.value = 'Mein Auto';
            }

            woAuto.welcome.value = false;

            await woAuto.save();
          },
          isTopSafeArea: true,
          next: const Text(
            'Weiter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          done: const Text(
            'Fertig',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          dotsDecorator: DotsDecorator(
            activeColor: getForegroundColor(context),
          ),
        ),
      ),
    );
  }
}
