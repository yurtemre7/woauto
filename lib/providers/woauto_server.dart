import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woauto/classes/car_park.dart';
import 'package:woauto/classes/wa_position.dart';
import 'package:woauto/classes/wa_simple_position.dart';
import 'package:woauto/main.dart';
import 'package:woauto/utils/constants.dart';
import 'package:woauto/utils/logger.dart';

class WoAutoServer extends GetxController {
  /// Our PocketBase instance
  late PocketBase pb;
  var httpClient = GetHttpClient(baseUrl: '$scheme$host:$port');

  var serverWorks = false.obs;

  // user data
  /// Only while app usage, will this be "live", else it will be the last location.
  var shareMyLastLiveLocation = false.obs;

  /// Thoses are your car parkings
  var shareMyParkings = false.obs;

  @override
  onClose() async {
    logMessage('Disposing WoAuto Server');
    await pb.realtime.unsubscribe();
    logMessage('Unsubscribed from all real-time subscriptions');
    super.onClose();
  }

  toJson() {
    return json.encode({
      'share_me': shareMyLastLiveLocation.value,
      'share_parkings': shareMyParkings.value,
    });
  }

  static WoAutoServer fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);
    var server = WoAutoServer();

    server.shareMyLastLiveLocation.value = jsonMap['share_me'] ?? false;
    server.shareMyParkings.value = jsonMap['share_parkings'] ?? false;
    return server;
  }

  // save to local storage
  save() async {
    var sp = woAuto.sp;
    sp.setString('woauto_server', toJson());
  }

  static Future<WoAutoServer> load() async {
    var sp = woAuto.sp;
    var jsonString = sp.getString('woauto_server');
    var server = WoAutoServer();
    if (jsonString != null) {
      server = WoAutoServer.fromJson(jsonString);
    }
    var prefs = await SharedPreferences.getInstance();

    var store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
    );

    server.pb = PocketBase('https://woauto.yurtemre.de', authStore: store);
    var hCheck = await server.pb.health.check();
    var code = hCheck.code;

    if (code >= 200 && code <= 299) {
      server.serverWorks.value = true;
    }

    server.initFriendsLocations();

    return server;
  }

  reset() {
    shareMyLastLiveLocation.value = false;
    shareMyParkings.value = false;
    save();
  }

  Future<void> initFriendsLocations() async {
    try {
      var user = await getUser(
        expand: 'friends,friends.position,friends.parkings,parkings,position',
      );

      if (user == null) return;

      var friends = user.expand['friends'];
      if (friends != null) {
        woAuto.friendCarMarkers.clear();
        woAuto.friendCarPositions.clear();
        for (var friend in friends) {
          var fPosition = friend.expand['position']?.first;
          if (fPosition != null) {
            logMessage('Position: ${fPosition.data}', tag: friend.id);
            var simplePosition = WaSimplePosition.fromRecord(fPosition);
            woAuto.addFriendPosition(
              newPosition: simplePosition.latLng,
              uuid: simplePosition.id,
              newName: friend.data['username'],
            );
          }
          var fParkings = friend.expand['parkings'];
          if (fParkings != null) {
            for (var fPark in fParkings) {
              logMessage('Parking ${fPark.id}: ${fPark.data}', tag: friend.id);
              var fPosition = WaPosition.fromRecord(fPark);
              woAuto.addFriendCarPosition(
                newPosition: fPosition.latLng,
                uuid: fPosition.id,
                newName: '${fPosition.name ?? 'Parking'} from ${friend.data['username']}',
              );
            }
          }

          pb.collection('users').subscribe(
            friend.id,
            expand: 'friends,friends.position,friends.parkings,parkings,position',
            (userData) async {
              var fUser = userData.record;
              if (fUser == null) return;
              logMessage('Friend updated', tag: fUser.id);
              var fPosition = fUser.expand['position']?.first;
              if (fPosition != null) {
                logMessage('Position: ${fPosition.data}', tag: fUser.id);
                var simplePosition = WaSimplePosition.fromRecord(fPosition);
                woAuto.addFriendPosition(
                  newPosition: simplePosition.latLng,
                  uuid: simplePosition.id,
                  newName: friend.data['username'],
                );
              } else {
                woAuto.deleteFriendPosition(uuid: fUser.id);
              }

              var fParkings = friend.expand['parkings'];
              if (fParkings != null) {
                for (var fPark in fParkings) {
                  logMessage('Parking ${fPark.id}: ${fPark.data}', tag: fUser.id);
                  var fPosition = WaPosition.fromRecord(fPark);
                  woAuto.addFriendCarPosition(
                    newPosition: fPosition.latLng,
                    uuid: fPosition.id,
                    newName: fPosition.name,
                  );
                }
              } else {
                woAuto.friendCarPositions.clear();
                woAuto.friendCarPositions.refresh();
                woAuto.save();
              }
            },
          );
        }
      }
    } catch (error, stackTrace) {
      logMessage(
        'Error has happened:\n\n${error.toString()}\n\n${stackTrace.toString()}',
        tag: 'ERROR',
      );
    }
  }

  Future<RecordModel?> getUser({String? id, String? expand}) async {
    RecordModel user;
    var localUser = pb.authStore.model as RecordModel?;
    if (localUser == null || !pb.authStore.isValid) return null;
    id ??= localUser.id;
    user = await pb.collection('users').getOne(id, expand: expand);
    logMessage('Fetched User $id: ${user.data}');
    if (expand != null) {
      // logMessage('User $id expanded: ${user.expand}');
    }
    return user;
  }

  Future<void> setUserLocation(LatLng position) async {
    try {
      // example create body
      var user = pb.authStore.model as RecordModel?;
      if (user == null || !pb.authStore.isValid) return;
      // var user = await pb.collection('users').getOne(userOld.id);
      var positionData = user.data['position'].toString().trim();
      // debugPrint(user.data.toString());
      RecordModel record;
      var body = <String, dynamic>{
        'latitude': position.latitude,
        'longitude': position.longitude,
        'user': user.id,
      };
      if (positionData.isEmpty) {
        record = await pb.collection('simple_position').create(body: body);
      } else {
        record = await pb.collection('simple_position').update(positionData, body: body);
      }

      await pb.collection('users').update(user.id, body: {
        'position': record.id,
      });
    } on ClientException catch (e) {
      var code = e.response['code'];
      var message = e.response['message'];
      logMessage('Fehler $code:\n$message');
    }
  }

  Future<void> deleteUserLocation() async {
    try {
      // example create body
      var user = pb.authStore.model as RecordModel?;
      if (user == null || !pb.authStore.isValid) return;
      // var user = await pb.collection('users').getOne(userOld.id);
      var positionData = user.data['position'].toString().trim();
      // debugPrint(user.data.toString());
      if (positionData.isEmpty) {
        return;
      } else {
        await pb.collection('simple_position').delete(positionData);
      }

      await pb.collection('users').update(user.id, body: {
        'position': null,
      });
    } on ClientException catch (e) {
      var code = e.response['code'];
      var message = e.response['message'];
      logMessage('Fehler $code:\n$message');
    }
  }

  Future<void> addUserParkingLocation(CarPark park) async {
    if (!shareMyParkings.value) {
      logMessage('Not Sharing Parking');
      return;
    }

    try {
      // example create body
      var user = pb.authStore.model as RecordModel?;
      if (user == null || !pb.authStore.isValid) return;
      // var user = await pb.collection('users').getOne(userOld.id);
      var parkingsData = user.data['parkings'] as List<dynamic>;

      if (parkingsData.isEmpty) {
        // create parking
        // example create body
        var body = <String, dynamic>{
          'latitude': park.latitude,
          'longitude': park.longitude,
          'name': park.name,
          'note': park.description,
          'user': user.id,
        };

        var parking = await pb.collection('positions').create(body: body);
        await pb.collection('users').update(user.id, body: {
          'parkings': parking.id,
        });
      } else {
        // update parking
        var parkingId = parkingsData.first;
        // example update body
        var body = <String, dynamic>{
          'latitude': park.latitude,
          'longitude': park.longitude,
          'name': park.name,
          'note': park.description,
        };
        var parking = await pb.collection('positions').update(
              parkingId,
              body: body,
            );
        await pb.collection('users').update(user.id, body: {
          'parkings': parking.id,
        });
      }
    } on ClientException catch (e) {
      var code = e.response['code'];
      var message = e.response['message'];
      logMessage('Fehler $code:\n$message');
    }
  }

  Future<void> deleteUserParkingLocations() async {
    try {
      // example create body
      var user = pb.authStore.model as RecordModel?;
      if (user == null || !pb.authStore.isValid) return;
      // var user = await pb.collection('users').getOne(userOld.id);
      var parkingsData = user.data['parkings'] as List<dynamic>;
      // debugPrint(user.data.toString());
      if (parkingsData.isEmpty) {
        return;
      } else {
        for (var parkingId in parkingsData) {
          await pb.collection('positions').delete(parkingId);
        }
      }

      await pb.collection('users').update(user.id, body: {
        'parkings': null,
      });
    } on ClientException catch (e) {
      var code = e.response['code'];
      var message = e.response['message'];
      logMessage('Fehler $code:\n$message');
    }
  }
}
