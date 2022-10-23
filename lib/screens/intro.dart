import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:location/location.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/screens/home.dart';
import 'package:woauto/utils/utilities.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var tec = TextEditingController(text: '');
  final allowed = false.obs;
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
              titleWidget: const Text(
                'WoAuto',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bodyWidget: Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/icon.png',
                          fit: BoxFit.contain,
                          width: 128,
                          height: 128,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Willkommen bei WoAuto',
                            style: TextStyle(fontSize: 20),
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: const Text(
                'App-Voreinstellungen',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bodyWidget: Container(
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Parkplatz-Titel setzen',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Div(),
                    const Text(
                      'Setze dir einen coolen Parkplatz-Titel für dein Auto.',
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: tec,
                      maxLength: 30,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Mein Auto',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'App-Theme einstellen',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Div(),
                    Row(
                      children: [
                        const Flexible(
                          child: Text(
                            'Entscheide selbst, ob du das Theme des Systems, das Light-Theme oder das Dark-Theme nutzen möchtest.',
                          ),
                        ),
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
                                // if (woAuto.mapController.value == null) return;
                                // await woAuto.setMapStyle(
                                //   brightness: v == 1
                                //       ? Brightness.light
                                //       : v == 2
                                //           ? Brightness.dark
                                //           : null,
                                // );
                                await woAuto.save();
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                            );

                            return dropdownButton;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (isAndroid()) ...[
                      Obx(
                        () => SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          value: woAuto.android13Theme.value,
                          title: const Text('Android 13 Design'),
                          subtitle: const Text(
                            'Entscheide selbst, ob du das neue Android 13 Design benutzen möchtest.',
                          ),
                          onChanged: (v) async {
                            woAuto.android13Theme.value = v;
                            await woAuto.save();
                            pop();
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      'Echtzeit-Standortabfragen erlauben',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Div(),
                    const Text(
                      'Erlaube der App, deinen Standort in Echtzeit während der App-Nutzung abzufragen. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.',
                    ),
                    const SizedBox(height: 10),
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
                          log(val.toString());
                          if (!val) {
                            allowed.value = val;
                            return;
                          }
                          var v = await Location().requestPermission();
                          allowed.value = v == PermissionStatus.granted;
                          showError.value = !allowed.value;
                        },
                      ),
                    )
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
            if (woAuto.parkings.isNotEmpty) {
              var myCar = woAuto.parkings.first;
              woAuto.addMarker(myCar.position);
            }

            woAuto.welcome.value = false;

            await woAuto.save();

            pushReplacement(const Home());
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
