import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woauto/components/div.dart';
import 'package:woauto/components/text_icon.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/utilities.dart';

class MapInfoSheet extends StatefulWidget {
  const MapInfoSheet({super.key});

  @override
  State<MapInfoSheet> createState() => _MapInfoSheetState();
}

class _MapInfoSheetState extends State<MapInfoSheet> {
  ScrollController scrollController = ScrollController();
  late SnappingSheetController snappingSheetController;

  bool up = false;

  @override
  void initState() {
    super.initState();
    snappingSheetController = woAuto.snappingSheetController.value;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var snapPos = snappingSheetController.currentSnappingPosition;
        var offset = snapPos.grabbingContentOffset;
        if (offset < 0) {
          snappingSheetController.snapToPosition(
            SnappingPosition.factor(
              positionFactor: 0.0,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: animationSpeed,
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
          );
          return false;
        }

        return await Get.bottomSheet(
          AlertDialog(
            title: const Text('App verlassen'),
            content: const Text('Möchtest du die App verlassen?'),
            actions: [
              TextButton(
                child: const Text('ABBRECHEN'),
                onPressed: () => Get.back(result: false),
              ),
              ElevatedButton(
                child: const Text('VERLASSEN'),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: SnappingSheet(
        controller: snappingSheetController,
        snappingPositions: [
          SnappingPosition.factor(
            positionFactor: 0.0,
            snappingCurve: Curves.easeOutExpo,
            snappingDuration: animationSpeed,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          SnappingPosition.factor(
            positionFactor: 0.6,
            snappingCurve: Curves.bounceOut,
            snappingDuration: animationSpeed,
            grabbingContentOffset: GrabbingContentOffset.bottom,
          ),
        ],
        grabbingHeight: minHeightSheet,
        lockOverflowDrag: true,
        grabbing: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    var snapPos = snappingSheetController.currentSnappingPosition;
                    var offset = snapPos.grabbingContentOffset;

                    scrollController.animateTo(
                      0,
                      duration: 250.milliseconds,
                      curve: Curves.linear,
                    );

                    if (offset > 0) {
                      snappingSheetController.snapToPosition(
                        SnappingPosition.factor(
                          positionFactor: 0.6,
                          snappingCurve: Curves.bounceOut,
                          snappingDuration: animationSpeed,
                          grabbingContentOffset: GrabbingContentOffset.bottom,
                        ),
                      );
                      return;
                    }
                    snappingSheetController.snapToPosition(
                      SnappingPosition.factor(
                        positionFactor: 0.0,
                        snappingCurve: Curves.easeOutExpo,
                        snappingDuration: animationSpeed,
                        grabbingContentOffset: GrabbingContentOffset.top,
                      ),
                    );
                  },
                  child: Container(
                    width: 110,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              FittedBox(
                child: SizedBox(
                  height: 50,
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      var textController = TextEditingController();
                      var tillTime = Rxn<TimeOfDay>();

                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Text('Neuer Parkplatz'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ListTile(
                                title: Text('Neuen Parkplatz speichern?'),
                              ),
                              ExpandablePanel(
                                header: const ListTile(
                                  title: Text('Zusätzliche Info zum Parkplatz'),
                                ),
                                collapsed: const SizedBox(),
                                expanded: Column(
                                  children: [
                                    ListTile(
                                      title: TextField(
                                        controller: textController,
                                        decoration: const InputDecoration(
                                          labelText: 'Info',
                                          hintText: 'z.B. Parkdeck 2',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      children: [
                                        Obx(
                                          () => ElevatedButton(
                                            onPressed: () async {
                                              // show time picker of today
                                              tillTime.value = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(alwaysUse24HourFormat: true),
                                                    child: child!,
                                                  );
                                                },
                                                helpText: 'Parkticket läuft ab um',
                                                confirmText: 'Speichern',
                                                cancelText: 'Abbrechen',
                                              );
                                            },
                                            child: Text(
                                              'Parkticket hinzufügen${tillTime.value == null ? '' : ' (${tillTime.value!.hour.toString().padLeft(2, '0')}:${tillTime.value!.minute.toString().padLeft(2, '0')})'}',
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.dialog(
                                              AlertDialog(
                                                title: const Text('Parkticket'),
                                                content: const Text(
                                                  'Wenn du ein Parkticket hast, kannst du hier die Uhrzeit angeben, bis zu der das Ticket gültig ist. '
                                                  'Dann erstellt die App dir einen Timer, der dich 10 Minuten vor Ende des Tickets benachrichtigt.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.question_mark),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('ABBRECHEN'),
                              onPressed: () {
                                pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('SPEICHERN'),
                              onPressed: () async {
                                woAuto.addMarker(
                                  woAuto.currentPosition.value.target,
                                  extra: textController.text,
                                );

                                if (tillTime.value != null) {
                                  var differenceInSecondsFromNow = tillTime.value!.hour * 3600 +
                                      tillTime.value!.minute * 60 -
                                      DateTime.now().hour * 3600 -
                                      DateTime.now().minute * 60 -
                                      DateTime.now().second;
                                  var title = '';

                                  // if difference bigger then 600 seconds (10 minutes)
                                  if (differenceInSecondsFromNow > 600) {
                                    differenceInSecondsFromNow -= 600;
                                    title = 'Dein Parkticket hält noch 10 Minuten an.';
                                  } else if (differenceInSecondsFromNow < 0) {
                                    differenceInSecondsFromNow += 86400 - 600;
                                    title = 'Dein Parkticket hält noch 10 Minuten an.';
                                  } else {
                                    title = 'Dein Parkticket ist abgelaufen.';
                                  }

                                  FlutterAlarmClock.createTimer(
                                    differenceInSecondsFromNow,
                                    title: title,
                                  );
                                }

                                if (woAuto.mapController.value == null) {
                                  return;
                                }

                                var snapPos = snappingSheetController.currentSnappingPosition;
                                var offset = snapPos.grabbingContentOffset;
                                if (offset < 0) {
                                  snappingSheetController.snapToPosition(
                                    SnappingPosition.factor(
                                      positionFactor: 0.0,
                                      snappingCurve: Curves.easeOutExpo,
                                      snappingDuration: animationSpeed,
                                      grabbingContentOffset: GrabbingContentOffset.top,
                                    ),
                                  );
                                }

                                woAuto.mapController.value!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: woAuto.currentPosition.value.target,
                                      zoom: 18,
                                    ),
                                  ),
                                );

                                pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    label: const Text(
                      'Parkplatz speichern',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.local_parking_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        sheetBelow: SnappingSheetContent(
          childScrollController: scrollController,
          child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 10),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const Text(
                          'Aktionen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Parkplatz Teilen'),
                          onPressed: () {
                            // share parking location to whatsapp, telegram etc.
                            if (woAuto.parkings.isEmpty) {
                              // show snackbar error
                              Get.snackbar(
                                'Fehler',
                                'Keinen Parkplatz gespeichert',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                duration: 2.seconds,
                              );
                              return;
                            }
                            var textEditing = TextEditingController(text: woAuto.subText.value);

                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text('Parkplatz teilen'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Du kannst den Parkplatz mit deinen Freunden teilen.',
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Welchen Namen soll der Parkplatz haben?'),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: textEditing,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Name',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Tipp: Wenn dein Freund auch die App nutzt, kann er den Parkplatz in der App auch einsehen mit dem neuen Link.',
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('ABBRECHEN'),
                                    onPressed: () {
                                      pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('TEILEN'),
                                    onPressed: () async {
                                      if (textEditing.text.replaceAll(' ', '').trim().isEmpty) {
                                        // show snackbar error
                                        Get.snackbar(
                                          'Fehler',
                                          'Keinen Name eingegeben',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.redAccent,
                                          borderRadius: 10,
                                          margin: const EdgeInsets.all(10),
                                          duration: 2.seconds,
                                        );
                                        return;
                                      }
                                      if (woAuto.parkings.isEmpty) {
                                        // show snackbar error
                                        Get.snackbar(
                                          'Fehler',
                                          'Keinen Parkplatz gespeichert',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.redAccent,
                                          borderRadius: 10,
                                          margin: const EdgeInsets.all(10),
                                          duration: 2.seconds,
                                        );
                                        return;
                                      }
                                      LatLng myCar = woAuto.parkings.elementAt(0).position;
                                      String website = 'https://yurtemre.de';
                                      String link =
                                          'https://www.google.com/maps?q=${myCar.latitude},${myCar.longitude}';
                                      String woLink =
                                          '$website/deeplink?title=${Uri.encodeFull(textEditing.text.trim())}&lat=${Uri.encodeFull(myCar.latitude.toString())}&long=${Uri.encodeFull(myCar.longitude.toString())}';
                                      String text =
                                          'Ich habe meinen Wagen hier geparkt: $woLink\n\n';

                                      text +=
                                          'Alternativ kannst du ihn auch über Google Maps einsehen: $link';

                                      pop();
                                      Share.share(text);
                                    },
                                  ),
                                ],
                              ),
                            );
                            return;
                          },
                        ),

                        TextButton.icon(
                          onPressed: () async {
                            GoogleMapController controller = woAuto.mapController.value!;
                            controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                woAuto.currentPosition.value,
                              ),
                            );

                            snappingSheetController.snapToPosition(
                              SnappingPosition.factor(
                                positionFactor: 0.0,
                                snappingCurve: Curves.easeOutExpo,
                                snappingDuration: animationSpeed,
                                grabbingContentOffset: GrabbingContentOffset.top,
                              ),
                            );
                          },
                          icon: const Icon(Icons.location_on_outlined),
                          label: const Text('Gehe zu meinem Standort'),
                        ),

                        // infos about your parking spot
                        Obx(
                          () {
                            var pinList = woAuto.pinList.toList();
                            var parkingList = woAuto.parkingList.toList();
                            return Visibility(
                              visible: parkingList.isNotEmpty || pinList.isNotEmpty,
                              child: Column(
                                children: [
                                  if (parkingList.isNotEmpty || pinList.isNotEmpty) ...[
                                    const Div(),
                                  ],
                                  if (parkingList.isNotEmpty) ...[
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Parkplätze',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    ...parkingList.toSet().map(
                                      (element) {
                                        return ListTile(
                                          title: Text(
                                            element['name'] +
                                                " - ${element['distance']} m entfernt",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                          subtitle: Text(
                                            element['address'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                          trailing: PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  child: TextIcon(
                                                    icon: Icon(
                                                      Icons.map_outlined,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    label: Text(
                                                      'In Google Maps öffnen',
                                                      style: TextStyle(
                                                        color:
                                                            Theme.of(context).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    launchUrl(
                                                      Uri.parse(
                                                        'https://www.google.com/maps?q=${element['lat']},${element['long']}',
                                                      ),
                                                      mode: LaunchMode.externalApplication,
                                                    );
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: TextIcon(
                                                    icon: Icon(
                                                      Icons.navigation_outlined,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    label: Text(
                                                      'Zum Parkplatz',
                                                      style: TextStyle(
                                                        color:
                                                            Theme.of(context).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    GoogleMapController controller =
                                                        woAuto.mapController.value!;
                                                    controller.animateCamera(
                                                      CameraUpdate.newCameraPosition(
                                                        CameraPosition(
                                                          target: LatLng(
                                                            element['lat'],
                                                            element['long'],
                                                          ),
                                                          zoom: 18,
                                                        ),
                                                      ),
                                                    );
                                                    snappingSheetController.snapToPosition(
                                                      SnappingPosition.factor(
                                                        positionFactor: 0.0,
                                                        snappingCurve: Curves.easeOutExpo,
                                                        snappingDuration: animationSpeed,
                                                        grabbingContentOffset:
                                                            GrabbingContentOffset.top,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: const TextIcon(
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    ),
                                                    label: Text(
                                                      'Parkplatz löschen',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    var id = element['id'].toString();
                                                    var ids = id.split(',');
                                                    int num = int.parse(ids[1]);
                                                    String type = ids[0];
                                                    if (type == 'park') {
                                                      woAuto.parkingList.removeAt(num);
                                                      woAuto.parkings.removeWhere(
                                                          (Marker element) =>
                                                              element.markerId.value == id);
                                                    } else {
                                                      woAuto.pinList.removeAt(num);
                                                      woAuto.pins.removeWhere((Marker element) =>
                                                          element.markerId.value == id);
                                                    }

                                                    woAuto.markers.clear();
                                                    woAuto.markers.addAll(woAuto.pins);
                                                    woAuto.markers.addAll(woAuto.parkings);

                                                    woAuto.save();

                                                    snappingSheetController.snapToPosition(
                                                      SnappingPosition.factor(
                                                        positionFactor: 0.0,
                                                        snappingCurve: Curves.easeOutExpo,
                                                        snappingDuration: animationSpeed,
                                                        grabbingContentOffset:
                                                            GrabbingContentOffset.top,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ];
                                            },
                                          ),
                                          onTap: () {
                                            GoogleMapController controller =
                                                woAuto.mapController.value!;
                                            controller.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    element['lat'],
                                                    element['long'],
                                                  ),
                                                  zoom: 18,
                                                ),
                                              ),
                                            );
                                            snappingSheetController.snapToPosition(
                                              SnappingPosition.factor(
                                                positionFactor: 0.0,
                                                snappingCurve: Curves.easeOutExpo,
                                                snappingDuration: animationSpeed,
                                                grabbingContentOffset: GrabbingContentOffset.top,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                  if (pinList.isNotEmpty) ...[
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Pins',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    ...pinList.toSet().map(
                                      (element) {
                                        return ListTile(
                                          title: Text(
                                            element['name'] +
                                                " - ${element['distance']} m entfernt",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                          subtitle: Text(
                                            element['address'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                          trailing: PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  child: TextIcon(
                                                    icon: Icon(
                                                      Icons.map_outlined,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    label: Text(
                                                      'in Google Maps öffnen',
                                                      style: TextStyle(
                                                        color:
                                                            Theme.of(context).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    launchUrl(
                                                      Uri.parse(
                                                        'https://www.google.com/maps?q=${element['lat']},${element['long']}',
                                                      ),
                                                      mode: LaunchMode.externalApplication,
                                                    );
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: TextIcon(
                                                    icon: Icon(
                                                      Icons.navigation_outlined,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    label: Text(
                                                      'Zum Parkplatz',
                                                      style: TextStyle(
                                                        color:
                                                            Theme.of(context).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    GoogleMapController controller =
                                                        woAuto.mapController.value!;
                                                    controller.animateCamera(
                                                      CameraUpdate.newCameraPosition(
                                                        CameraPosition(
                                                          target: LatLng(
                                                            element['lat'],
                                                            element['long'],
                                                          ),
                                                          zoom: 18,
                                                        ),
                                                      ),
                                                    );
                                                    snappingSheetController.snapToPosition(
                                                      SnappingPosition.factor(
                                                        positionFactor: 0.0,
                                                        snappingCurve: Curves.easeOutExpo,
                                                        snappingDuration: animationSpeed,
                                                        grabbingContentOffset:
                                                            GrabbingContentOffset.top,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: const TextIcon(
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    ),
                                                    label: Text(
                                                      'Parkplatz löschen',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    var id = element['id'].toString();
                                                    var ids = id.split(',');
                                                    int num = int.parse(ids[1]);
                                                    String type = ids[0];
                                                    if (type == 'park') {
                                                      woAuto.parkingList.removeAt(num);
                                                      woAuto.parkings.removeWhere(
                                                          (Marker element) =>
                                                              element.markerId.value == id);
                                                    } else {
                                                      woAuto.pinList.removeAt(num);
                                                      woAuto.pins.removeWhere((Marker element) =>
                                                          element.markerId.value == id);
                                                    }

                                                    woAuto.markers.clear();
                                                    woAuto.markers.addAll(woAuto.pins);
                                                    woAuto.markers.addAll(woAuto.parkings);

                                                    woAuto.save();

                                                    snappingSheetController.snapToPosition(
                                                      SnappingPosition.factor(
                                                        positionFactor: 0.0,
                                                        snappingCurve: Curves.easeOutExpo,
                                                        snappingDuration: animationSpeed,
                                                        grabbingContentOffset:
                                                            GrabbingContentOffset.top,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ];
                                            },
                                          ),
                                          onTap: () {
                                            GoogleMapController controller =
                                                woAuto.mapController.value!;
                                            controller.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                    element['lat'],
                                                    element['long'],
                                                  ),
                                                  zoom: 18,
                                                ),
                                              ),
                                            );
                                            snappingSheetController.snapToPosition(
                                              SnappingPosition.factor(
                                                positionFactor: 0.0,
                                                snappingCurve: Curves.easeOutExpo,
                                                snappingDuration: animationSpeed,
                                                grabbingContentOffset: GrabbingContentOffset.top,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                  const SizedBox(height: 15),
                                  TextButton.icon(
                                    icon: const Icon(Icons.question_mark),
                                    label: const Text(
                                      'Wie wird die Entfernung berechnet, fragst du dich?',
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Get.snackbar(
                                        'Wie wird die Entfernung berechnet?',
                                        'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        titleText: Text(
                                          'Wie wird die Entfernung berechnet?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        messageText: Column(
                                          children: [
                                            Text(
                                              'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context).colorScheme.secondary,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Tippe um mehr zu erfahren.',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        borderRadius: 12,
                                        margin: const EdgeInsets.all(20),
                                        duration: 10.seconds,
                                        onTap: (snack) {
                                          launchUrl(
                                            Uri.parse(
                                              'https://en.wikipedia.org/wiki/Haversine_formula',
                                            ),
                                            mode: LaunchMode.externalApplication,
                                          );
                                        },
                                        backgroundColor: Theme.of(context).colorScheme.surface,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
