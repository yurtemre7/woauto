import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:woauto/i18n/translations.g.dart';

class CarPark {
  final String uuid;
  final bool mine;
  String name;
  int? createdAt;
  int? updatedAt;
  double latitude;
  double longitude;
  String? adresse;
  String? description;
  String? photoPath;

  int? until;

  CarPark({
    required this.uuid,
    required this.mine,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.adresse,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.photoPath,
    this.until,
  });

  factory CarPark.fromJson(Map<String, dynamic> json) {
    return CarPark(
      uuid: json['uuid'],
      mine: json['mine'] ?? false,
      name: json['name'] ?? t.constants.default_park_title,
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      adresse: json['adresse'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      description: json['description'],
      photoPath: json['photoPath'],
      until: json['until'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'mine': mine,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'adresse': adresse,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'description': description,
      'photoPath': photoPath,
      'until': until,
    };
  }

  LatLng get latLng => LatLng(latitude, longitude);
}
