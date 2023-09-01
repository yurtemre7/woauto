import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarPark {
  final String uuid;
  String name;
  int? createdAt;
  int? updatedAt;
  double latitude;
  double longitude;
  String? adresse;
  bool sharing;
  String? description;
  String? photoPath;

  String viewKey = '';
  String editKey = '';
  int? until;

  CarPark({
    required this.uuid,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.adresse,
    this.createdAt,
    this.updatedAt,
    this.sharing = false,
    this.description,
    this.photoPath,
    this.viewKey = '',
    this.editKey = '',
    this.until,
  });

  factory CarPark.fromJson(Map<String, dynamic> json) {
    return CarPark(
      uuid: json['uuid'],
      name: json['name'] ?? 'Mein Auto',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      adresse: json['adresse'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      sharing: json['sharing'] ?? false,
      description: json['description'],
      photoPath: json['photoPath'],
      viewKey: json['viewKey'] ?? '',
      editKey: json['editKey'] ?? '',
      until: json['until'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'adresse': adresse,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sharing': sharing,
      'description': description,
      'photoPath': photoPath,
      'viewKey': viewKey,
      'editKey': editKey,
      'until': until,
    };
  }

  LatLng get latLng => LatLng(latitude, longitude);

  bool get mine => sharing ? editKey.isNotEmpty : true;
}
