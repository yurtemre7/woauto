class CardLocation {
  String id;
  String lat;
  String long;
  String name;
  String createdAt;

  CardLocation(this.id, this.lat, this.long, this.name, this.createdAt);

  factory CardLocation.fromJson(Map<String, dynamic> json) {
    var location = json['msg'];
    return CardLocation(
      location[0].toString(),
      location[1].toString(),
      location[2].toString(),
      location[3].toString(),
      location[4].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': [id, name, lat, long, createdAt],
    };
  }
}
