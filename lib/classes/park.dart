class Park {
  String id;
  double latitude;
  double longitude;
  int? datum;
  String? name;
  String? address;
  bool? shared;
  double distance;
  String extra;
  bool onlineSync = false;
  String onlineID = '';

  Park({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.datum,
    this.name,
    this.address = '',
    this.shared = false,
    required this.distance,
    this.extra = '',
    this.onlineSync = false,
    this.onlineID = '',
  });

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
      'extra': extra,
      'onlineSync': onlineSync,
      'onlineID': onlineID,
    };
  }

  Park.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        latitude = json['lat'],
        longitude = json['long'],
        datum = json['datum'] ?? DateTime.now().millisecondsSinceEpoch,
        name = json['name'],
        address = json['address'] ?? '',
        shared = json['shared'] ?? false,
        distance = json['distance'],
        extra = json['extra'] ?? '',
        onlineSync = json['onlineSync'] ?? false,
        onlineID = json['onlineID'] ?? '';
}
