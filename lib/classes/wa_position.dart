import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/classes/wa_object.dart';

class WaPosition extends WaObject {
  final String id;
  final double latitude;
  final double longitude;
  final String? name;
  final String? note;
  final String userId;

  WaPosition(
    super.recordModel, {
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.userId,
    this.name,
    this.note,
  });

  LatLng get latLng => LatLng(latitude, longitude);
}
