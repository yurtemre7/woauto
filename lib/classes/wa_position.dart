import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:woauto/classes/wa_car.dart';
import 'package:woauto/classes/wa_object.dart';

class WaPosition extends WaObject {
  final String id;
  final double latitude;
  final double longitude;
  final String? name;
  final String? note;
  final WaCar? car;
  final String userId;

  WaPosition(
    super.recordModel, {
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.userId,
    this.car,
    this.name,
    this.note,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  factory WaPosition.fromRecord(RecordModel model) {
    return WaPosition(
      model,
      id: model.id,
      latitude: model.data['latitude'].toDouble(),
      longitude: model.data['longitude'].toDouble(),
      userId: model.data['user'],
      car: model.expand['car'] == null
          ? null
          : WaCar.fromRecord(model.expand['car']!.first),
      name: model.data['name'],
      note: model.data['note'],
    );
  }
}
