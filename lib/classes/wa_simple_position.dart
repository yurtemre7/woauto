import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocketbase/pocketbase.dart';

class WaSimplePosition {
  final String id;
  final double latitude;
  final double longitude;
  final String userId;

  WaSimplePosition({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.userId,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  factory WaSimplePosition.fromRecord(RecordModel model) {
    return WaSimplePosition(
      id: model.id,
      latitude: model.data['latitude'],
      longitude: model.data['longitude'],
      userId: model.data['user'],
    );
  }
}
