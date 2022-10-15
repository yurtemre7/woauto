import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 5),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Einstellungen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListTile(
                          title: Obx(
                            () => Text('Parkplatz-Titel: ${woAuto.subText.value}'),
                          ),
                          subtitle: const Text(
                              'Verändere hiermit den Text, welcher bei deinem Parkplatz steht, z B.: Mercedes, Audi oder BMW'),
                          onTap: () {
                            var tec = TextEditingController(text: woAuto.subText.value);
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text('Auto Text'),
                                content: TextFormField(
                                  controller: tec,
                                  maxLength: 30,
                                  autocorrect: false,
                                  autofocus: true,
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Abbrechen'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('OK'),
                                    onPressed: () async {
                                      woAuto.subText.value = tec.text.trim();
                                      woAuto.addMarker(
                                          LatLng(woAuto.latitude.value!, woAuto.longitude.value!));
                                      await woAuto.save();
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Div(),
                        if (isAndroid()) ...[
                          Obx(
                            () => SwitchListTile(
                              value: woAuto.android13Theme.value,
                              title: const Text('Android 13 Design nutzen'),
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
                          const Div(),
                        ],
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
                                if (woAuto.mapController.value == null) return;
                                await woAuto.setMapStyle(
                                  brightness: v == 1
                                      ? Brightness.light
                                      : v == 2
                                          ? Brightness.dark
                                          : null,
                                );
                                await woAuto.save();
                                pop();
                              },
                            );

                            return ListTile(
                              title: const Text('Theme'),
                              subtitle: const Text(
                                'Entscheide selbst, ob du das Theme des Systems, das Light-Theme oder das Dark-Theme nutzen möchtest.',
                              ),
                              trailing: dropdownButton,
                            );
                          },
                        ),
                        const Div(),
                        Obx(
                          () => ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text('App Info'),
                            subtitle: Text('Version ${woAuto.appVersion}+${woAuto.appBuildNumber}'),
                            onTap: () {
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: const Text('App Info'),
                                  content: const Text(
                                    'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.',
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text('Github'),
                                      onPressed: () {
                                        launchUrl(
                                          Uri.parse('https://github.com/yurtemre7/woauto'),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const Div(),
                        const ListTile(
                          leading: Icon(Icons.volunteer_activism_outlined),
                          title: Text('Credits'),
                          subtitle: Text(
                              'Icon von Icons8.com, Google Maps API und natürlich der Flutter-Community.'),
                        ),
                        const Div(),
                        ListTile(
                          leading: const Icon(Icons.share),
                          title: const Text('Teilen'),
                          subtitle: const Text('Teile unsere App mit deinen Freunden'),
                          onTap: () {
                            Share.share(
                              'Hast du auch vergessen wo du zuletzt geparkt hast? '
                              'Nun ist schluss. '
                              'Mit WoAuto kannst du deinen Parkplatz ganz leicht speichern und nachher einsehen, teilen und sogar hinnavigieren.\n'
                              'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\n'
                              'Downloade es dir doch und probiere es selbst: https://play.google.com/store/apps/details?id=de.emredev.woauto',
                            );
                          },
                        ),
                        const Div(),
                        ListTile(
                          leading: const Icon(Icons.feedback_outlined),
                          title: const Text('Feedback'),
                          subtitle: const Text(
                              'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?'),
                          onTap: () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text('Feedback'),
                                content: const Text(
                                  'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:',
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text('Telegram-Channel'),
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse('https://t.me/programmiererfreunde'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Telegram (Privat)'),
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse('https://t.me/emredev'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Div(),
                        ListTile(
                          leading: const Icon(Icons.gpp_good_sharp),
                          title: const Text('Datenschutz und Impressum'),
                          subtitle: const Text('Teile unsere App mit deinen Freunden'),
                          onTap: () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text('Datenschutz und Impressum'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 14.10.2022):',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.',
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '- Die App speichert keine Meta-Daten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.',
                                      ),
                                      SizedBox(height: 5),
                                      Text.rich(
                                        TextSpan(
                                          text:
                                              '- Die App speichert natürlich, unter anderem, deinen Standort, Name des Parkplatzes und die Koordinaten, aber teilt diese ',
                                          children: [
                                            TextSpan(
                                              text: 'weder mit Dritten, als auch nicht uns selbst.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' Es gibt tatsächlich keinen Datenaustausch mit einem Server, außer den Google Servern beim Bereitstellen der Google Maps Karten. ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'Die App speichert die Daten nur auf deinem Gerät, welche du jederzeit (in den Einstellungen ganz unten) löschen kannst.',
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text('Impressum'),
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse('https://www.yurtemre.de/impressum'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Datenschutz'),
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse('https://www.yurtemre.de/datenschutz'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Div(),
                        ListTile(
                          leading: const Icon(Icons.delete_forever_outlined),
                          title: const Text('Lösche alle App-Daten'),
                          subtitle: const Text(
                              'Halte hier gedrückt um all deine App-Daten zu löschen. App-Daten sind dann nicht mehr wiederherstellbar.'),
                          onLongPress: () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text('App-Daten löschen'),
                                content: const Text('Möchtest du alle App-Daten löschen?'),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Löschen'),
                                    onPressed: () async {
                                      await woAuto.reset();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Abbrechen'),
                                    onPressed: () {
                                      pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
