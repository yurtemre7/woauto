import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class MyCar extends StatefulWidget {
  const MyCar({super.key});

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
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
                    'Mein Auto',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: getForegroundColor(context),
                    ),
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              Obx(
                () => SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      16.h,
                      ListTile(
                        title: Text(
                          'Name: ${woAuto.subText.value}',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text(
                            'Ändere den Namen, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW'),
                        onTap: () {
                          var tec = TextEditingController(text: woAuto.subText.value);
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text('Name des Parkplatzes'),
                              content: TextFormField(
                                controller: tec,
                                maxLength: 30,
                                autocorrect: false,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  hintText: 'Mein Auto',
                                ),
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
                                    if (woAuto.subText.value.isEmpty) {
                                      woAuto.subText.value = 'Mein Auto';
                                    }
                                    if (woAuto.parkings.isNotEmpty) {
                                      var myCar = woAuto.parkings.first;
                                      woAuto.addMarker(myCar.position);
                                    }

                                    await woAuto.save();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            name: 'Parkplatz-Titel',
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Kennzeichen: ${woAuto.kennzeichen.value}',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text('Ändere das Kennzeichen deines Autos'),
                        onTap: () {
                          var tec = TextEditingController(text: woAuto.kennzeichen.value);
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text('Kennzeichen'),
                              content: TextFormField(
                                controller: tec,
                                maxLength: 15,
                                textCapitalization: TextCapitalization.characters,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  hintText: 'B DE 1234',
                                ),
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
                                    woAuto.kennzeichen.value = tec.text.trim();

                                    await woAuto.save();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            name: 'Kennzeichen',
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Kilometerstand (km)',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text('Ändere den Kilometerstand deines Autos'),
                        trailing: Container(
                          constraints: const BoxConstraints(maxWidth: 90),
                          child: TextFormField(
                            initialValue: woAuto.kilometerStand.value.toString(),
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: '123456',
                              // isCollapsed: true,
                              contentPadding: EdgeInsets.zero,

                              helperStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onChanged: (String? value) {
                              if (value == null) return;
                              woAuto.kilometerStand.value = value;
                              woAuto.save();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                          title: Text(
                            'TÜV bis ${formatDateTimeToMonthYear(woAuto.tuvUntil.value)}',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                          subtitle: const Text('Ändere das Datum, an dem dein TÜV abläuft'),
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: woAuto.tuvUntil.value,
                              firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
                              lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
                              helpText: 'Gebe als Tag den "1." an, z.B. "1.1.2022"',
                            );
                            if (date == null) return;
                            woAuto.tuvUntil.value = date;
                            await woAuto.save();
                            Get.back();
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined),
                            color: Theme.of(context).colorScheme.primary,
                            tooltip: 'Zum Kalender hinzufügen',
                            onPressed: () async {
                              // add to google
                              var event = Event(
                                title: 'TÜV abgelaufen',
                                description:
                                    'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team',
                                location: '',
                                startDate: woAuto.tuvUntil.value.subtract(1.seconds),
                                endDate: woAuto.tuvUntil.value.add(1.seconds),
                                allDay: true,
                                iosParams: const IOSParams(
                                  reminder: Duration(
                                    days: 30, // einen Monat vorher erinnern
                                  ),
                                ),
                              );
                              Add2Calendar.addEvent2Cal(event);
                            },
                          )),
                      if (woAuto.tuvUntil.value.difference(DateTime.now()).isNegative) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: const Text('Dein TÜV ist abgelaufen!'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (!woAuto.tuvUntil.value.difference(DateTime.now()).isNegative) ...[
                        if (DateTime.now().difference(woAuto.tuvUntil.value).abs() < 30.days)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Theme.of(context).colorScheme.errorContainer,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: const Text(
                                      'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
