import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: getBackgroundColor(context),
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 100.0,
              forceElevated: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(
                  bottom: 14.0,
                  left: 20.0,
                ),
                title: Text(
                  'Einstellungen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: getForegroundColor(context),
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  16.h,
                  Column(
                    children: [
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

                              await woAuto.setMapStyle(
                                brightness: v == 1
                                    ? Brightness.light
                                    : v == 2
                                        ? Brightness.dark
                                        : null,
                              );
                              await woAuto.save();
                              if (!mounted) return;
                              Future.delayed(500.milliseconds, () {
                                SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle(
                                    systemNavigationBarColor: v == 1
                                        ? woAuto.dayColorScheme.value.background
                                        : v == 2
                                            ? woAuto.nightColorScheme.value.background
                                            : Theme.of(context).colorScheme.background,
                                  ),
                                );
                              });

                              // pop();
                            },
                          );

                          return ListTile(
                            title: Text(
                              'Theme',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                            subtitle: const Text(
                              'Entscheide selbst, ob du das System-Theme, das Light-Theme oder das Dark-Theme verwenden möchtest.',
                            ),
                            trailing: dropdownButton,
                          );
                        },
                      ),
                      Obx(
                        () {
                          var mapType = woAuto.mapType.value;
                          DropdownButton<MapType> dropdownButton = DropdownButton<MapType>(
                            value: mapType,
                            items: const [
                              DropdownMenuItem(
                                value: MapType.normal,
                                child: Text('Normal'),
                              ),
                              DropdownMenuItem(
                                value: MapType.satellite,
                                child: Text('Satellit'),
                              ),
                              DropdownMenuItem(
                                value: MapType.hybrid,
                                child: Text('Hybrid'),
                              ),
                              DropdownMenuItem(
                                value: MapType.terrain,
                                child: Text('Terrain'),
                              ),
                            ],
                            onChanged: (v) async {
                              woAuto.mapType.value = v!;
                              // pop();
                            },
                          );

                          return ListTile(
                            title: Text(
                              'Map-Typ',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                            subtitle: const Text(
                              'Zeigt die Karte in verschiedenen Typen an.',
                            ),
                            trailing: dropdownButton,
                          );
                        },
                      ),
                      Obx(
                        () => SwitchListTile(
                          value: woAuto.showTraffic.value,
                          title: Text(
                            'Verkehr',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                          subtitle: const Text(
                            'Zeigt den Verkehr auf der Karte an, sofern verfügbar.',
                          ),
                          onChanged: (v) async {
                            woAuto.showTraffic.value = v;
                            await woAuto.save();
                          },
                        ),
                      ),
                      Obx(
                        () {
                          var time = woAuto.timePuffer.value;
                          DropdownButton<int> dropdownButton = DropdownButton<int>(
                            value: time,
                            items: const [
                              DropdownMenuItem(
                                value: 5,
                                child: Text('5 Minuten'),
                              ),
                              DropdownMenuItem(
                                value: 10,
                                child: Text('10 Minuten'),
                              ),
                              DropdownMenuItem(
                                value: 15,
                                child: Text('15 Minuten'),
                              ),
                              DropdownMenuItem(
                                value: 20,
                                child: Text('20 Minuten'),
                              ),
                              DropdownMenuItem(
                                value: 25,
                                child: Text('25 Minuten'),
                              ),
                              DropdownMenuItem(
                                value: 30,
                                child: Text('30 Minuten'),
                              ),
                            ],
                            onChanged: (v) {
                              woAuto.timePuffer.value = v!;
                              woAuto.save();
                              // pop();
                            },
                          );

                          return ListTile(
                            title: Text(
                              'Parkticket Zeitpuffer',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                            subtitle: const Text(
                              'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.',
                            ),
                            trailing: dropdownButton,
                          );
                        },
                      ),
                      Obx(
                        () {
                          var speed = woAuto.drivingModeDetectionSpeed.value;
                          DropdownButton<int> dropdownButton = DropdownButton<int>(
                            value: speed,
                            items: const [
                              DropdownMenuItem(
                                value: 20,
                                child: Text('20 km/h'),
                              ),
                              DropdownMenuItem(
                                value: 25,
                                child: Text('25 km/h'),
                              ),
                              DropdownMenuItem(
                                value: 30,
                                child: Text('30 km/h'),
                              ),
                              DropdownMenuItem(
                                value: 35,
                                child: Text('35 km/h'),
                              ),
                              DropdownMenuItem(
                                value: 40,
                                child: Text('40 km/h'),
                              ),
                            ],
                            onChanged: (v) {
                              woAuto.drivingModeDetectionSpeed.value = v!;
                              woAuto.save();
                              // pop();
                            },
                          );

                          return ListTile(
                            title: Text(
                              'Driving Modus Erkennung',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                            subtitle: const Text(
                              'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.',
                            ),
                            trailing: dropdownButton,
                          );
                        },
                      ),
                      const Div(),
                      Obx(
                        () => ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            'App Info',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
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
                              name: 'App Info',
                            );
                          },
                        ),
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.volunteer_activism_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(
                          'Credits',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text(
                          'Dank an Google Maps API und natürlich an die Flutter Community.',
                        ),
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.share_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(
                          'App Teilen',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text(
                            'Teile die App doch mit deinen Freunden und deiner Familie.'),
                        onTap: () {
                          Share.share(
                            'Hast du auch vergessen, wo du zuletzt geparkt hast? '
                            'Jetzt ist Schluss. '
                            'Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\n'
                            'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\n'
                            'Warum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto',
                          );
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.feedback_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(
                          'Feedback',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
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
                            name: 'Feedback',
                          );
                        },
                      ),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.gpp_good_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: Text(
                          'Datenschutz und Impressum',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text('Erfahre wie deine Daten geschützt werden.'),
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text('Datenschutz und Impressum'),
                              content: const SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                                      '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.',
                                    ),
                                    SizedBox(height: 5),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ',
                                        children: [
                                          TextSpan(
                                            text: 'weder an Dritte noch an uns weiter.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '\nEs findet kein Datenaustausch mit einem Server statt, außer mit den Servern von Google bei der Bereitstellung der Google Maps Karten. ',
                                          ),
                                          TextSpan(
                                            text:
                                                'Die App speichert die Daten nur auf deinem Gerät und du kannst sie jederzeit löschen (in den Einstellungen ganz unten).',
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
                            name: 'Datenschutz und Impressum',
                          );
                        },
                      ),
                      const Div(),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete_forever_outlined,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        title: Text(
                          'Lösche alle App-Daten',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        subtitle:
                            const Text('Halte hier gedrückt, um all deine App-Daten zu löschen.'),
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
                                    foregroundColor: Theme.of(context).colorScheme.error,
                                  ),
                                  child: const Text('Löschen'),
                                  onPressed: () async {
                                    // pop();
                                    pop();
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
                            name: 'App-Daten löschen',
                          );
                        },
                      ),
                      16.h,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
