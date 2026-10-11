import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsLauncher {
  /// Returns a [Uri] that can be launched on the current platform
  /// to open a maps application showing the result of a search query.
  static Uri createQueryUri(String query) {
    if (kIsWeb) {
      return Uri.https(
        'www.google.com',
        '/maps/search/',
        {'api': '1', 'query': query},
      );
    } else if (Platform.isAndroid) {
      return Uri(scheme: 'geo', host: 'ul', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      return Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      return Uri.https(
        'www.google.com',
        '/maps/search/',
        {'api': '1', 'query': query},
      );
    }
  }

  /// Returns a [Uri] that can be launched on the current platform
  /// to open a maps application showing coordinates ([latitude] and [longitude]).
  static Uri createCoordinatesUri(
    double latitude,
    double longitude, [
    String? label,
  ]) {
    if (kIsWeb) {
      return Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';
      if (label != null) query += '($label)';
      return Uri(scheme: 'geo', host: 'ul', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {
        'll': '$latitude,$longitude',
        'q': label ?? '$latitude, $longitude',
      };
      return Uri.https('maps.apple.com', '/', params);
    } else {
      return Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
    }
  }

  static Future<LaunchMode> _launchMode() async {
    if (await supportsLaunchMode(LaunchMode.externalNonBrowserApplication)) {
      return LaunchMode.externalNonBrowserApplication;
    } else if (await supportsLaunchMode(LaunchMode.externalApplication)) {
      return LaunchMode.externalApplication;
    } else {
      return LaunchMode.platformDefault;
    }
  }

  /// Launches the maps application for this platform.
  /// The maps application will show the result of the provided search [query].
  static Future<bool> launchQuery(String query) async {
    var uri = createQueryUri(query);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: await _launchMode());
    }
    // Fallback to Google Maps web search
    var fallbackUri = Uri.https(
      'www.google.com',
      '/maps/search/',
      {'api': '1', 'query': query},
    );
    return await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
  }

  /// Launches the maps application for this platform.
  /// The maps application will show the specified coordinates.
  static Future<bool> launchCoordinates(
    double latitude,
    double longitude, [
    String? label,
  ]) async {
    var uri = createCoordinatesUri(latitude, longitude, label);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: await _launchMode());
    }
    // Fallback to Google Maps web search
    var fallbackUri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': '$latitude,$longitude',
    });
    return await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
  }
}
