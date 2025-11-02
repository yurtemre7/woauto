import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';

bool isAndroid() => GetPlatform.isAndroid;
bool isIOS() => GetPlatform.isIOS;

String? darkMapStyle;
String? lightMapStyle;

const darkBg = Color(0xff1B1A1D);

final animationSpeed = 800.milliseconds;

Future loadMapStyles() async {
  darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
  lightMapStyle = await rootBundle.loadString('assets/map_styles/light.json');
}

void pop<T>({T? result}) => Get.back<T>(result: result);

void push(Widget page) => Get.to(() => page);

void pushReplacement(Widget page) => Get.offAll(() => page);

double maxHeightSheet = Get.size.height * 0.7;
const double minHeightSheet = 107;

Color getBackgroundColor(BuildContext context) {
  if (woAuto.themeMode.value != 0) {
    return woAuto.themeMode.value == 1 ? Colors.white : darkBg;
  }
  return Theme.of(context).colorScheme.surface;
}

Color getForegroundColor(BuildContext context) {
  if (woAuto.themeMode.value != 0) {
    return woAuto.themeMode.value != 1 ? Colors.white : darkBg;
  }
  return Theme.of(context).colorScheme.surfaceTint;
}

Future<String?> getAddress(LatLng position) async {
  try {
    await setLocaleIdentifier(
      '${Get.locale?.languageCode ?? 'de'}_${Get.locale?.countryCode ?? 'DE'}',
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String street = placemarks.first.thoroughfare ?? '';
    String city = placemarks.first.locality ?? '';
    String number = placemarks.first.subThoroughfare ?? '';

    if (number.isEmpty && city.isNotEmpty && street.isNotEmpty) {
      return '$street, $city';
    }
    if (number.isEmpty && city.isEmpty && street.isNotEmpty) {
      return street;
    }
    if (number.isEmpty && city.isNotEmpty && street.isEmpty) {
      return city;
    }
    if (number.isNotEmpty && city.isEmpty && street.isEmpty) {
      return t.constants.address_na;
    }
    if (street.isEmpty && city.isEmpty && number.isEmpty) {
      return t.constants.address_na;
    }
    if (number.isNotEmpty && city.isNotEmpty && street.isEmpty) {
      return '$number, $city';
    }
    if (number.isNotEmpty && city.isEmpty && street.isNotEmpty) {
      return '$street $number';
    }

    return '$street $number, $city';
  } catch (e) {
    return t.constants.address_na;
  }
}

String formatDateTimeToYear(DateTime dateTime) {
  return '${dateTime.year}';
}

String formatDateTimeToMonthYear(DateTime dateTime) {
  // leading zero
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  return '${twoDigits(dateTime.month)}.${dateTime.year}';
}

String formatDateTimeToTimeAndDate(DateTime dateTime) {
  // leading zero
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  return '${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)} ${twoDigits(dateTime.day)}.${twoDigits(dateTime.month)}.${dateTime.year}';
}

String formatDateTimeAndTime(DateTime dateTime) {
  // difference to now
  var now = DateTime.now();
  var difference = now.difference(dateTime);

  var minutes = difference.inMinutes % 60;
  var hours = difference.inHours % 24;
  var days = difference.inDays % 365;

  // if less than a minute
  if (difference.inMinutes <= 0) {
    return t.constants.parked_rn;
  }

  String durationString = '';

  // show all data
  if (days > 0) {
    durationString += t.park_duration.days(n: days);
    durationString += ' ';
  }
  if (hours > 0) {
    durationString += t.park_duration.hours(n: hours);
    durationString += ' ';
  }
  if (minutes > 0) {
    durationString += t.park_duration.minutes(n: minutes);
  }

  return t.constants.parked_duration_string(duration: durationString);
}

List<int> quickSort(List<int> list) {
  if (list.length <= 1) return list;

  var pivot = list[list.length ~/ 2];
  var equal = list.where((element) => element == pivot).toList();
  var less = list.where((element) => element < pivot).toList();
  var greater = list.where((element) => element > pivot).toList();

  return [...quickSort(less), ...equal, ...quickSort(greater)];
}

ThemeMode getThemeMode(int themeMode) {
  switch (themeMode) {
    case 0:
      return ThemeMode.system;
    case 1:
      return ThemeMode.light;
    case 2:
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

int calculateCarAge(String year) {
  var now = DateTime.now();
  var yearInt = int.parse(year);
  return now.year - yearInt;
}

double uuidToHue(String uuid) {
  // Convert the UUID to bytes
  List<int> bytes = utf8.encode(uuid);

  // Simple hash function to process the bytes
  int hash = 0;
  for (int byte in bytes) {
    hash = (hash * 31 + byte) & 0xFFFFFFFF;
  }

  // Map the hash value to a hue value between 0 and 360
  double hue = (hash % 360).toDouble();

  return hue;
}
