import 'dart:io';
import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/utilities.dart';

class MyCar extends StatefulWidget {
  const MyCar({super.key});

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  var maxHeight = 128.0;
  var minHeight = 64.0;

  var height = 128.0.obs;

  final big = true.obs;

  Future<void> showPictureBottomSheet() async {
    Get.bottomSheet(
      Card(
        color: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Foto aufnehmen'),
                leading: const Icon(Icons.camera_alt),
                onTap: () async {
                  pop();
                  XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

                  if (image == null) return;

                  String duplicateFilePath = (await getApplicationDocumentsDirectory()).path;

                  var fileName = image.path.split('/').last;
                  File localImage = await File(image.path).copy('$duplicateFilePath/$fileName');
                  woAuto.carPicture.value = localImage.path;
                  woAuto.save();
                },
              ),
              const Div(),
              ListTile(
                title: const Text('Foto auswählen'),
                leading: const Icon(Icons.photo),
                onTap: () async {
                  pop();
                  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

                  if (image == null) return;

                  String duplicateFilePath = (await getApplicationDocumentsDirectory()).path;

                  var fileName = image.path.split('/').last;
                  File localImage = await File(image.path).copy('$duplicateFilePath/$fileName');
                  woAuto.carPicture.value = localImage.path;
                  woAuto.save();
                },
              ),
              const Div(),
              ListTile(
                title: Text(
                  'Foto löschen',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                leading: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
                onTap: () {
                  pop();
                  woAuto.carPicture.value = '';
                  woAuto.save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                actions: [
                  Obx(
                    () => Switch(
                      value: big.value,
                      onChanged: (value) {
                        big.toggle();
                        if (big.value) {
                          height.value = maxHeight;
                        } else {
                          height.value = minHeight;
                        }
                      },
                    ),
                  ),
                ],
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              Obx(
                () => SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Center(
                        child: Column(
                          children: [
                            AnimatedContainer(
                              alignment: Alignment.center,
                              duration: 450.milliseconds,
                              height: height.value * pi,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(height.value),
                                onTap: () {
                                  showPictureBottomSheet();
                                },
                                onLongPress: () {
                                  big.toggle();
                                  if (big.value) {
                                    height.value = maxHeight;
                                  } else {
                                    height.value = minHeight;
                                  }
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: height.value,
                                      backgroundImage: woAuto.carPicture.isEmpty
                                          ? null
                                          : FileImage(File(woAuto.carPicture.value)),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primaryContainer,
                                    ),
                                    if (woAuto.carPicture.isEmpty)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        top: 0,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 42,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            // 8.h,

                            if (woAuto.carPicture.isNotEmpty)
                              Center(
                                child: Card(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  elevation: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          woAuto.subText.value,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        if (woAuto.kennzeichen.value.isNotEmpty)
                                          Text(
                                            woAuto.kennzeichen.value,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                        if (woAuto.carBaujahr.value.isNotEmpty)
                                          Text(
                                            'Baujahr: ${woAuto.carBaujahr.value}',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                        if (woAuto.kilometerStand.value.isNotEmpty)
                                          Text(
                                            '${woAuto.kilometerStand.value} km gefahren',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      16.h,
                      ListTile(
                        title: Text(
                          'Titel: ${woAuto.subText.value}',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: const Text(
                            'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW'),
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
                        title: Badge(
                          isLabelVisible: woAuto.carBaujahr.value.isEmpty,
                          child: Text(
                            'Baujahr: ${woAuto.carBaujahr.value}',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        subtitle: const Text('Ändere das Baujahr deines Autos'),
                        onTap: () {
                          var tec = TextEditingController(text: woAuto.carBaujahr.value);
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text('Baujahr'),
                              content: TextFormField(
                                controller: tec,
                                maxLength: 4,
                                autocorrect: false,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  hintText: '2002',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                    woAuto.carBaujahr.value = tec.text.trim();

                                    await woAuto.save();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            name: 'Baujahr',
                          );
                        },
                      ),
                      ListTile(
                        title: Badge(
                          isLabelVisible: woAuto.kennzeichen.value.isEmpty,
                          child: Text(
                            'Kennzeichen: ${woAuto.kennzeichen.value}',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
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
                        title: Badge(
                          isLabelVisible: woAuto.kilometerStand.value.isEmpty,
                          child: Text(
                            'Kilometerstand: ${woAuto.kilometerStand.value + (woAuto.kilometerStand.value.isNotEmpty ? ' km' : '')}',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        subtitle: const Text('Ändere den Kilometerstand deines Autos'),
                        onTap: () {
                          var tec =
                              TextEditingController(text: woAuto.kilometerStand.value.toString());
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text('Kennzeichen'),
                              content: TextFormField(
                                controller: tec,
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
                                    woAuto.kilometerStand.value = tec.text.trim();

                                    await woAuto.save();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            name: 'Kilometerstand',
                          );
                        },
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
                        trailing: (!woAuto.tuvUntil.value.difference(DateTime.now()).isNegative)
                            ? IconButton(
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
                              )
                            : null,
                      ),
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
                      16.h,
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
