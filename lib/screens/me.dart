import 'dart:io';
import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/components/login_dialog.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/extensions.dart';
import 'package:woauto/utils/logger.dart';
import 'package:woauto/utils/utilities.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  final WoAutoServer woAutoServer = Get.find();

  var maxHeight = 128.0;
  var minHeight = 64.0;

  var height = 64.0.obs;

  final big = false.obs;

  @override
  void initState() {
    super.initState();
  }

  Future<void> showPictureBottomSheet() async {
    Get.bottomSheet(
      Card(
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(t.bottom_sheet.camera),
                  leading: const Icon(Icons.camera_alt),
                  onTap: () async {
                    pop();
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);

                    if (image == null) return;

                    String duplicateFilePath =
                        (await getApplicationDocumentsDirectory()).path;

                    var fileName = image.path.split('/').last;
                    File localImage = await File(image.path)
                        .copy('$duplicateFilePath/$fileName');
                    woAuto.carPicture.value = localImage.path;
                    woAuto.save();
                  },
                ),
                const Div(),
                ListTile(
                  title: Text(t.bottom_sheet.photo),
                  leading: const Icon(Icons.photo),
                  onTap: () async {
                    pop();
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image == null) return;

                    String duplicateFilePath =
                        (await getApplicationDocumentsDirectory()).path;

                    var fileName = image.path.split('/').last;
                    File localImage = await File(image.path)
                        .copy('$duplicateFilePath/$fileName');
                    woAuto.carPicture.value = localImage.path;
                    woAuto.save();
                  },
                ),
                if (woAuto.carPicture.isNotEmpty) ...[
                  const Div(),
                  ListTile(
                    title: Text(
                      t.bottom_sheet.photo_delete,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    leading: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onTap: () async {
                      try {
                        File localImage = File(woAuto.carPicture.value);
                        if (await localImage.exists()) {
                          await localImage.delete();
                        }
                      } catch (e) {
                        logMessage('Couldn\'t delete image: $e');
                      }

                      pop();
                      woAuto.carPicture.value = '';
                      woAuto.save();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteAccountSheet() async {
    Get.bottomSheet(
      Card(
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.dialog.account_data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                4.h,
                Text(
                  t.dialog.account_data.content,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                12.h,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => pop(),
                        child: Text(t.dialog.abort),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.theme.colorScheme.error,
                          backgroundColor:
                              context.theme.colorScheme.errorContainer,
                        ),
                        onPressed: () async {
                          var user = await woAutoServer.getUser();
                          if (user == null) return;
                          await woAutoServer.pb
                              .collection('users')
                              .delete(user.id);
                          woAutoServer.pb.authStore.clear();
                          woAuto.friendPositions.clear();
                          woAuto.friendCarPositions.clear();
                          woAutoServer.reset();
                          await woAuto.reset();
                          woAuto.save();
                          pop();
                          setState(() {});
                          pop();
                        },
                        child: Text(t.dialog.account_data.title),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                    t.my_car.title,
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
                  8.w,
                ],
                backgroundColor: Theme.of(context).colorScheme.surface,
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
                                borderRadius:
                                    BorderRadius.circular(height.value),
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
                                          : FileImage(
                                              File(woAuto.carPicture.value),
                                            ),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      onBackgroundImageError:
                                          woAuto.carPicture.isEmpty
                                              ? null
                                              : (exception, stackTrace) {
                                                  woAuto.carPicture.value = '';
                                                  woAuto.save();
                                                },
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            // 8.h,

                            if (woAuto.carPicture.isNotEmpty)
                              Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            SharePlus.instance.share(
                                              ShareParams(
                                                text: t.my_car.shared_content,
                                                files: [
                                                  XFile(
                                                    woAuto.carPicture.value,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.share_outlined),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Card(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
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
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              if (woAuto
                                                  .kennzeichen.value.isNotEmpty)
                                                Text(
                                                  woAuto.kennzeichen.value,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              if (woAuto
                                                  .carBaujahr.value.isNotEmpty)
                                                Text(
                                                  t.my_car.built.title(
                                                    baujahr:
                                                        woAuto.carBaujahr.value,
                                                    jahre: calculateCarAge(
                                                      woAuto.carBaujahr.value,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              if (woAuto.kilometerStand.value
                                                  .isNotEmpty)
                                                Text(
                                                  t.my_car.driven.title(
                                                    km: woAuto
                                                        .kilometerStand.value,
                                                  ),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: 0.h,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      16.h,
                      if (woAutoServer.pb.authStore.isValid) ...[
                        Builder(
                          builder: (context) {
                            var user =
                                woAutoServer.pb.authStore.model as RecordModel;
                            return SelectionArea(
                              child: ListTile(
                                title: Text(
                                  '@${user.data['username']}',
                                  style: TextStyle(
                                    color: context.theme.colorScheme.primary,
                                  ),
                                ),
                                subtitle: Text('${user.data['email']}'),
                                trailing: IconButton(
                                  onPressed: () async {
                                    return await Get.dialog(
                                      AlertDialog(
                                        title: Text(t.dialog.logout),
                                        content: Text(t.dialog.logout_confirm),
                                        actions: [
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: context
                                                  .theme.colorScheme.error,
                                            ),
                                            onPressed: () {
                                              woAutoServer.pb.authStore.clear();
                                              woAuto.friendPositions.clear();
                                              woAuto.friendCarPositions.clear();
                                              woAutoServer.reset();
                                              woAuto.save();
                                              pop();
                                              setState(() {});
                                            },
                                            child: Text(t.dialog.logout),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.logout_outlined,
                                  ),
                                  iconSize: 38,
                                  style: IconButton.styleFrom(
                                    foregroundColor:
                                        context.theme.colorScheme.error,
                                    disabledForegroundColor:
                                        Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SwitchListTile(
                          title: Text(
                            t.my_car.share_my_last_location,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          subtitle: Text(
                            t.my_car.share_my_last_location_description,
                          ),
                          value: woAutoServer.shareMyLastLiveLocation.value,
                          onChanged: (s) async {
                            if (s == false) {
                              var res = await Get.dialog(
                                    AlertDialog(
                                      title: Text(
                                        t.dialog.share_location_parkings.title,
                                      ),
                                      content: Text(
                                        t.my_car
                                            .share_my_last_location_deactivate,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            pop(result: false);
                                          },
                                          child: Text(t.dialog.abort),
                                        ),
                                        OutlinedButton(
                                          onPressed: () async {
                                            // delete
                                            await woAutoServer
                                                .deleteUserLocation();
                                            pop(result: true);
                                          },
                                          child: Text(
                                            t.dialog.share_location_parkings
                                                .deactivate,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                  false;

                              if (res == false) return;
                            }
                            woAutoServer.shareMyLastLiveLocation.toggle();
                            woAutoServer.save();
                          },
                        ),
                        SwitchListTile(
                          title: Text(
                            t.my_car.share_my_parkings,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          subtitle:
                              Text(t.my_car.share_my_parkings_description),
                          value: woAutoServer.shareMyParkings.value,
                          onChanged: (s) async {
                            if (s == false) {
                              var res = await Get.dialog(
                                    AlertDialog(
                                      title: Text(
                                        t.dialog.share_location_parkings.title,
                                      ),
                                      content: Text(
                                        t.my_car.share_my_parkings_deactivate,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            pop(result: false);
                                          },
                                          child: Text(t.dialog.abort),
                                        ),
                                        OutlinedButton(
                                          onPressed: () async {
                                            await woAutoServer
                                                .deleteUserParkingLocations();
                                            pop(result: true);
                                          },
                                          child: Text(
                                            t.dialog.share_location_parkings
                                                .deactivate,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                  false;

                              if (res == false) return;
                            }
                            woAutoServer.shareMyParkings.toggle();
                            woAutoServer.save();
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            t.my_car.share_deactivate_info,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Center(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: context.theme.colorScheme.error,
                              backgroundColor:
                                  context.theme.colorScheme.errorContainer,
                            ),
                            onPressed: () async {
                              showDeleteAccountSheet();
                            },
                            child: Text(t.dialog.account_data.title),
                          ),
                        ),
                        const Divider(),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: OutlinedButton(
                            onPressed: () async {
                              await Get.bottomSheet(
                                const LoginSheet(),
                                isScrollControlled: true,
                              );

                              setState(() {});
                            },
                            child: Text(t.my_car.login_register),
                          ),
                        ),
                      ],
                      ListTile(
                        title: Text(
                          t.my_car.park_name.title(name: woAuto.subText.value),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(t.my_car.park_name.subtitle),
                        onTap: () {
                          var tec =
                              TextEditingController(text: woAuto.subText.value);
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(t.my_car.park_name.park_title),
                              content: TextFormField(
                                controller: tec,
                                maxLength: 30,
                                autocorrect: false,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: t.constants.default_park_title,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(t.dialog.abort),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                OutlinedButton(
                                  child: Text(t.dialog.ok),
                                  onPressed: () async {
                                    var oldName = woAuto.subText.value;
                                    woAuto.subText.value = tec.text.trim();
                                    if (woAuto.subText.value.isEmpty) {
                                      woAuto.subText.value =
                                          t.constants.default_park_title;
                                    }
                                    if (woAuto.carParkings.isNotEmpty) {
                                      for (var element in woAuto.carParkings) {
                                        if (element.name == oldName) {
                                          element.name = woAuto.subText.value;
                                        }
                                      }
                                    }
                                    woAuto.carParkings.refresh();
                                    woAuto.save();
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
                            t.my_car.built
                                .title_short(baujahr: woAuto.carBaujahr.value),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        subtitle: Text(t.my_car.built.subtitle),
                        onTap: () {
                          var tec = TextEditingController(
                            text: woAuto.carBaujahr.value,
                          );
                          var formkey = GlobalKey<FormState>();
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(t.my_car.built.title_dialog),
                              content: Form(
                                key: formkey,
                                child: TextFormField(
                                  controller: tec,
                                  maxLength: 4,
                                  autocorrect: false,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: t.my_car.built.default_year,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    if (value == null) {
                                      return t.my_car.built.validate_null;
                                    }
                                    int year = int.tryParse(value) ?? 0;
                                    if (year < 1900 ||
                                        year > DateTime.now().year) {
                                      return t.my_car.built.validate_year(
                                        year: DateTime.now().year,
                                      );
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(t.dialog.abort),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                OutlinedButton(
                                  child: Text(t.dialog.ok),
                                  onPressed: () async {
                                    if (!formkey.currentState!.validate()) {
                                      return;
                                    }
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
                            t.my_car.plate
                                .title(plate: woAuto.kennzeichen.value),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        subtitle: Text(t.my_car.plate.subtitle),
                        onTap: () {
                          var tec = TextEditingController(
                            text: woAuto.kennzeichen.value,
                          );
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(t.my_car.plate.title_short),
                              content: TextFormField(
                                controller: tec,
                                maxLength: 15,
                                textCapitalization:
                                    TextCapitalization.characters,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: t.my_car.plate.hint,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(t.dialog.abort),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                OutlinedButton(
                                  child: Text(t.dialog.ok),
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
                            t.my_car.driven.title_short(
                              km: woAuto.kilometerStand.value +
                                  (woAuto.kilometerStand.value.isNotEmpty
                                      ? ' km'
                                      : ''),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        subtitle: Text(t.my_car.driven.subtitle),
                        onTap: () {
                          var tec = TextEditingController(
                            text: woAuto.kilometerStand.value.toString(),
                          );
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(t.my_car.driven.title_dialog),
                              content: TextFormField(
                                controller: tec,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: t.my_car.driven.hint,
                                  // isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,

                                  helperStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(t.dialog.abort),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                OutlinedButton(
                                  child: Text(t.dialog.ok),
                                  onPressed: () async {
                                    woAuto.kilometerStand.value =
                                        tec.text.trim();

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
                          t.my_car.tuv.title(
                            date: formatDateTimeToMonthYear(
                              woAuto.tuvUntil.value,
                            ),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(t.my_car.tuv.subtitle),
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: woAuto.tuvUntil.value,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365 * 10)),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 365 * 10)),
                            helpText: t.my_car.tuv.help,
                            initialDatePickerMode: DatePickerMode.year,
                          );
                          if (date == null) return;
                          woAuto.tuvUntil.value = date;
                          await woAuto.save();
                          Get.back();
                        },
                        trailing: (!woAuto.tuvUntil.value
                                .difference(DateTime.now())
                                .isNegative)
                            ? IconButton(
                                icon: const Icon(Icons.calendar_month_outlined),
                                color: Theme.of(context).colorScheme.primary,
                                tooltip: t.my_car.tuv.add_to_calender,
                                onPressed: () async {
                                  // add to google
                                  var event = Event(
                                    title: t.my_car.tuv.calender_title,
                                    description: t.my_car.tuv.calender_content,
                                    location: '',
                                    startDate: woAuto.tuvUntil.value
                                        .subtract(1.seconds),
                                    endDate:
                                        woAuto.tuvUntil.value.add(1.seconds),
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
                      if (woAuto.tuvUntil.value
                          .difference(DateTime.now())
                          .isNegative) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(t.my_car.tuv.expired_info),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (!woAuto.tuvUntil.value
                          .difference(DateTime.now())
                          .isNegative) ...[
                        if (DateTime.now()
                                .difference(woAuto.tuvUntil.value)
                                .abs() <
                            30.days)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      t.my_car.tuv.expiring_info,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                      8.h,
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            woAuto.currentIndex(3);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Icon(
                                    Icons.info_outline,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Text(
                                    t.my_car.secure_notice,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
