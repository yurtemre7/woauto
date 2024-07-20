import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:woauto/classes/wa_object.dart';

class WaSimplePosition extends WaObject {
  final String id;
  final double latitude;
  final double longitude;
  final String userId;

  WaSimplePosition(
    super.recordModel, {
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.userId,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  factory WaSimplePosition.fromRecord(RecordModel model) {
    return WaSimplePosition(
      model,
      id: model.id,
      latitude: model.data['latitude'].toDouble(),
      longitude: model.data['longitude'].toDouble(),
      userId: model.data['user'],
    );
  }
}
