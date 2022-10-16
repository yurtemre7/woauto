import 'dart:async';
import 'dart:developer';
import 'package:uni_links/uni_links.dart';

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
        default:
          break;
      }
    } catch (e) {
      log('AppmldrLinks Error: ${e.toString()}');
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