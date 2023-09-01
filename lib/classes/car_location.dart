class CardLocation {
  String id;
  String lat;
  String long;
  String name;
  String createdAt;
  String view = '';
  String accountId = '';

  CardLocation(
    this.id,
    this.lat,
    this.long,
    this.name,
    this.createdAt, {
    this.view = '',
    this.accountId = '',
  });

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

  factory CardLocation.fromSPJson(Map<String, dynamic> json) {
    var location = json['msg'];
    return CardLocation(
      location[0].toString(),
      location[1].toString(),
      location[2].toString(),
      location[3].toString(),
      location[4].toString(),
      view: location[5] != null ? location[5].toString() : '',
      accountId: location[6] != null ? location[6].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': [id, name, lat, long, createdAt, view, accountId],
    };
  }
}
