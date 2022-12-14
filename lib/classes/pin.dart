import 'package:woauto/classes/park.dart';

class Pin extends Park {
  Pin({
    required super.id,
    required super.latitude,
    required super.longitude,
    super.name,
    super.datum,
    super.address = '',
    super.shared = true,
    required super.distance,
  });

  @override
  toJson() {
    return {
      'id': id,
      'lat': latitude,
      'long': longitude,
      'datum': datum,
      'name': name,
      'address': address,
      'shared': shared,
      'distance': distance,
    };
  }

  Pin.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          latitude: json['lat'],
          longitude: json['long'],
          datum: json['datum'],
          name: json['name'],
          address: json['address'] ?? '',
          shared: json['shared'] ?? true,
          distance: json['distance'],
          extra: json['extra'] ?? '',
        );
}
