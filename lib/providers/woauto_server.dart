import 'dart:convert';
import 'package:get/get.dart';
import 'package:woauto/classes/account.dart';
import 'package:woauto/classes/car_location.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/logger.dart';

class WoAutoServer extends GetxController {
  var httpClient = GetHttpClient(baseUrl: scheme + host);

  var locations = <String, CardLocation>{}.obs;
  var accounts = <String, Account>{}.obs;

  toJson() {
    return json.encode({
      'locations': locations.values.map((e) => e.toJson()).toList(),
      'accounts': accounts.values.map((e) => e.toJson()).toList(),
    });
  }

  static WoAutoServer fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);
    var server = WoAutoServer();
    jsonMap['locations'].forEach((e) {
      var location = CardLocation.fromJson(e);
      server.locations[location.id] = location;
    });
    jsonMap['accounts'].forEach((e) {
      var account = Account.fromJson(e);
      server.accounts[account.id] = account;
    });
    return server;
  }

  // save to local storage
  save() async {
    var sp = woAuto.sp;
    sp.setString('woauto_server', toJson());
  }

  static WoAutoServer load() {
    var sp = woAuto.sp;
    var jsonString = sp.getString('woauto_server');
    if (jsonString == null) {
      return WoAutoServer();
    }
    return WoAutoServer.fromJson(jsonString);
  }

  reset() {
    locations.clear();
    accounts.clear();
    save();
  }

  Future<Account?> createLocation(CarPark park, String until) async {
    try {
      var response = await httpClient.post(
        createPath,
        query: {
          'uuid': park.uuid,
          'name': park.name,
          'lat': park.latitude.toString(),
          'long': park.longitude.toString(),
          'until': until,
        },
      );
      var jsonMap = json.decode(response.body);
      if (jsonMap['msg'] is! List) {
        return null;
      }
      Account account = Account.fromJson(jsonMap);
      save();
      return account;
    } catch (e) {
      logMessage(e.toString());
      return null;
    }
  }

  Future<Account?> updateLocation({required CarPark park}) async {
    try {
      var response = await httpClient.post(
        updatePath,
        query: {
          'name': park.name,
          'lat': park.latitude.toString(),
          'long': park.longitude.toString(),
          'uuid': park.uuid,
          'edit': park.editKey,
        },
      );
      var jsonMap = json.decode(response.body);
      if (jsonMap['msg'] is! List) {
        return null;
      }
      Account account = Account.fromJson(jsonMap);
      save();
      return account;
    } catch (e) {
      logMessage(e.toString());
      return null;
    }
  }

  Future<CardLocation?> getLocation({required String id, required String view}) async {
    try {
      var response = await httpClient.get(
        getPath,
        query: {
          'uuid': id,
          'view': view,
        },
      );
      var jsonMap = json.decode(response.body);
      if (jsonMap['msg'] is! List) {
        return null;
      }
      CardLocation location = CardLocation.fromJson(jsonMap);
      save();
      return location;
    } catch (e) {
      logMessage(e.toString());
      return null;
    }
  }
}
