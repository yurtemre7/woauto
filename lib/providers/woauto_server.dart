import 'dart:convert';
import 'package:get/get.dart';
import 'package:woauto/classes/account.dart';
import 'package:woauto/classes/car_location.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';

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

  Future<String> createLocation(String name, String lat, String long, String until) async {
    var response = await httpClient.post(
      createPath,
      query: {
        'name': name,
        'lat': lat,
        'long': long,
        'until': until,
      },
    );
    // account
    var jsonMap = json.decode(response.body);
    Account account = Account.fromJson(jsonMap);
    accounts[account.id] = account;
    save();
    return account.id;
  }

  Future<bool> updateLocation(
    String id,
    String edit, {
    String? name,
    String? lat,
    String? long,
  }) async {
    var response = await httpClient.post(
      updatePath,
      query: {
        if (name != null) 'name': name,
        if (lat != null) 'lat': lat,
        if (long != null) 'long': long,
        'id': id,
        'edit': edit,
      },
    );
    // account
    var jsonMap = json.decode(response.body);
    Account account = Account.fromJson(jsonMap);
    accounts[account.id] = account;
    save();
    return response.statusCode == 200;
  }

  Future<bool> getLocation(String id, String view) async {
    var response = await httpClient.get(
      getPath,
      query: {
        'id': id,
        'view': view,
      },
    );
    // location
    var jsonMap = json.decode(response.body);
    CardLocation location = CardLocation.fromJson(jsonMap);
    locations[location.id] = location;
    save();
    return response.statusCode == 200;
  }
}
