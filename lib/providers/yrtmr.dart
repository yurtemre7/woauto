/*
  In dieser Datei wird meine Custom Deeplink-Implementierung für die App WoAuto
  beschrieben. Damit kann das Betriebssystem (Android oder iOS) die App öffnen
  wenn ein bestimmter Link angeklickt wird. In diesem Fall wird die App geöffnet und
  ein neuer Pin auf der Karte hinzugefügt.

  Emre Yurtseven
*/

import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/i18n/translations.g.dart';
import 'package:woauto/main.dart';
import 'package:woauto/providers/woauto_server.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/logger.dart';

class YrtmrDeeplinks {
  static YrtmrDeeplinks? _instance;
  static final appLinks = AppLinks();
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
      logMessage('initYrtmrLinks');
      YrtmrDeeplinks appmldrLinks = YrtmrDeeplinks.getInstance();

      if (appmldrLinks.once) {
        return;
      }
      var initialUri = await appLinks.getInitialLink();
      appmldrLinks.once = true;

      if (initialUri == null) {
        logMessage('YrtmrLinks: No initial link found.');
        return;
      }

      var deeplink = appmldrLinks.parseUri(initialUri);
      // logMessage('YrtmrLinks: Opening App Link: ${deeplink.toString()}');
      await appmldrLinks.handleDeeplink(deeplink);

      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on FormatException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  static StreamSubscription<Uri?> yrtmrLinksListener() {
    return appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri == null) {
        // log('YrtmrLinks: No initial link found.');
        return;
      }
      YrtmrDeeplinks yrtmrLinks = YrtmrDeeplinks.getInstance();

      var deeplink = yrtmrLinks.parseUri(uri);
      // log('YrtmrLinks: ${deeplink.toString()}');
      await yrtmrLinks.handleDeeplink(deeplink);
      yrtmrLinks.once = true;
      // Use the uri and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      return null;
    });
  }

  Future<void> handleDeeplink(YrtmrDeeplink deeplink) async {
    try {
      logMessage('Handling deeplink: ${deeplink.link}..');
      logMessage(deeplink.params.toString());

      switch (deeplink.link) {
        // case 'add-location':
        //   await addLocation(deeplink);
        default:
          return;
      }
    } catch (e) {
      logMessage('YrtmrDeeplinks Error: ${e.toString()}');
    }
  }

  // addLocation(YrtmrDeeplink deeplink) async {
  //   String? id = deeplink.params['id'];
  //   String? view = deeplink.params['view'];
  //   String? name = deeplink.params['name'];

  //   if (id == null || view == null || name == null) {
  //     return;
  //   }
  //   logMessage('Adding Location: $name, $id, $view');
  //   WoAutoServer woAutoServer = Get.find();
  //   var location = await woAutoServer.getLocation(id: id, view: view);
  //   if (location == null) {
  //     return;
  //   }
  //   await woAuto.addAnotherCarPark(
  //     newPosition: LatLng(double.parse(location.lat), double.parse(location.long)),
  //     newName: location.name,
  //     uuid: id,
  //     view: view,
  //   );
  //   Get.snackbar(
  //     t.snackbar.shared_parking.title,
  //     t.snackbar.shared_parking.subtitle,
  //     snackPosition: SnackPosition.TOP,
  //     borderRadius: 12,
  //     margin: const EdgeInsets.all(20),
  //     backgroundColor: Get.theme.colorScheme.surface,
  //     colorText: Get.theme.colorScheme.onSurface,
  //   );
  //   if (woAuto.mapController.value != null) {
  //     woAuto.mapController.value!.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(
  //             double.parse(location.lat),
  //             double.parse(location.long),
  //           ),
  //           zoom: CAM_ZOOM,
  //         ),
  //       ),
  //     );
  //   }
  // }

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
