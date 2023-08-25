/*
  In dieser Datei wird meine Custom Deeplink-Implementierung für die App WoAuto
  beschrieben. Damit kann das Betriebssystem (Android oder iOS) die App öffnen
  wenn ein bestimmter Link angeklickt wird. In diesem Fall wird die App geöffnet und
  ein neuer Pin auf der Karte hinzugefügt.

  Emre Yurtseven
*/

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:woauto/main.dart';

class YrtmrDeeplinks {
  static YrtmrDeeplinks? _instance;
  bool once = false;

  YrtmrDeeplinks._() {
    _instance = this;
  }

  static YrtmrDeeplinks getInstance() {
    return _instance ?? YrtmrDeeplinks._();
  }

  dispose() {
    _instance!.once = false;
  }

  static Future<void> initYrtmrLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      log('initYrtmrLinks');
      YrtmrDeeplinks appmldrLinks = YrtmrDeeplinks.getInstance();

      if (appmldrLinks.once) {
        return;
      }
      var initialUri = await getInitialUri();
      appmldrLinks.once = true;

      if (initialUri == null) {
        // log('AppmldrLinks: No initial link found.');
        return;
      }

      var deeplink = appmldrLinks.parseUri(initialUri);
      // log('AppmldrLinks: Opening App Link: ${deeplink.toString()}');
      await appmldrLinks.handleDeeplink(deeplink);

      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on FormatException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  static StreamSubscription<Uri?> yrtmrLinksListener() {
    return uriLinkStream.listen((Uri? uri) async {
      if (uri == null) {
        // log('AppmldrLinks: No initial link found.');
        return;
      }
      YrtmrDeeplinks appmldrLinks = YrtmrDeeplinks.getInstance();

      var deeplink = appmldrLinks.parseUri(uri);
      // log('AppmldrLinks: ${deeplink.toString()}');
      await appmldrLinks.handleDeeplink(deeplink);
      appmldrLinks.once = true;
      // Use the uri and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      return null;
    });
  }

  Future<void> handleDeeplink(YrtmrDeeplink deeplink) async {
    try {
      log('Handling deeplink: ${deeplink.link}..');
      log(deeplink.params.toString());

      switch (deeplink.link) {
        case 'add-pin':
          await addPin(deeplink);
          break;
        case 'add-location':
          // TODO fetch with ID and VIEW and then add to locations and save, add pin to map
          break;
        default:
          break;
      }
    } catch (e) {
      log('YrtmrDeeplinks Error: ${e.toString()}');
    }
  }

  addPin(YrtmrDeeplink deeplink) async {
    String? lat = deeplink.params['lat'];
    String? long = deeplink.params['long'];
    String title = deeplink.params['title'] ?? 'Anderer Parkplatz';

    if (lat == null || long == null) {
      return;
    }
    log('Adding pin: $title, $lat, $long');
    await woAuto.addPin(LatLng(double.parse(lat), double.parse(long)), title);
    Get.snackbar(
      'Ein geteilter Parkplatz wurde hinzugefügt',
      'Schaue auf der Karte oder in der Liste nach.',
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.colorScheme.surface,
      colorText: Get.theme.colorScheme.onSurface,
    );
    if (woAuto.mapController.value != null) {
      woAuto.mapController.value!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              double.parse(lat),
              double.parse(long),
            ),
            zoom: 18,
          ),
        ),
      );
    }
  }

  YrtmrDeeplink parseUri(Uri deeplink) {
    return YrtmrDeeplink(
      deeplink.path.length > 1 ? deeplink.path.substring(1) : '',
      deeplink.queryParameters,
    );
  }
}

class YrtmrDeeplink {
  String link;
  Map<String, String> params;
  YrtmrDeeplink(this.link, this.params);

  @override
  String toString() {
    return 'YrtmrDeeplink{link: $link,\n params: ${params.toString()}}';
  }
}
