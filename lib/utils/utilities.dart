import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/main.dart';

bool isAndroid() => GetPlatform.isAndroid;
bool isIOS() => GetPlatform.isIOS;

String? darkMapStyle;
String? lightMapStyle;

const darkBg = Color(0xff1B1A1D);

Future loadMapStyles() async {
  darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
  lightMapStyle = await rootBundle.loadString('assets/map_styles/light.json');
  woAuto.setMapStyle();
}

void pop<T>({T? result}) => Get.back<T>(result: result);

void push(Widget page) => Get.to(() => page);

void pushReplacement(Widget page) => Get.offAll(() => page);

double maxHeightSheet = Get.size.height * 0.7;
const double minHeightSheet = 107;

Color? getBackgroundColor(context) {
  if (woAuto.themeMode.value != 0) {
    return woAuto.themeMode.value == 1 ? Colors.white : darkBg;
  }
  return MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : darkBg;
}

Color? getForegroundColor(context) {
  if (woAuto.themeMode.value != 0) {
    return woAuto.themeMode.value != 1 ? Colors.white : darkBg;
  }
  return MediaQuery.of(context).platformBrightness != Brightness.light ? Colors.white : darkBg;
}

Future<String?> getAddress(LatLng position) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  String street = placemarks.first.thoroughfare ?? '';
  String city = placemarks.first.locality ?? '';
  String number = placemarks.first.subThoroughfare ?? '';
  return '$street $number, $city';
}

String formatDateTimeAndTime(DateTime dateTime) {
  // leading zero
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  // difference to now
  var now = DateTime.now();
  var difference = now.difference(dateTime);

  // if less than a minute
  if (difference.inMinutes <= 0) {
    return 'gerade eben geparkt';
  }

  // if less than an hour
  if (difference.inHours <= 0) {
    return 'vor ${difference.inMinutes} Minute${difference.inMinutes == 1 ? '' : 'n'} geparkt';
  }

  // if less than a day
  if (difference.inDays <= 0) {
    return 'vor ${difference.inHours} Stunde${difference.inHours == 1 ? '' : 'n'} geparkt';
  }

  // if less than a week
  if (difference.inDays <= 7) {
    return 'vor ${difference.inDays} Tag${difference.inDays == 1 ? '' : 'en'} geparkt';
  }

  // if less than a month
  if (difference.inDays <= 30) {
    return 'vor ${difference.inDays ~/ 7} Woche${difference.inDays ~/ 7 == 1 ? '' : 'n'} geparkt';
  }

  return 'Am ${twoDigits(dateTime.day)}.${twoDigits(dateTime.month)}.${dateTime.year} um ${twoDigits(dateTime.hour)}:${twoDigits(dateTime.minute)} geparkt';
}
