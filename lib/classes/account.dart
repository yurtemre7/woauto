class Account {
  String id;
  String until;
  String editKey;
  String viewKey;
  String locationId;

  Account(this.id, this.until, this.editKey, this.viewKey, this.locationId);

  factory Account.fromJson(Map<String, dynamic> json) {
    var account = json['msg'];
    return Account(
      account[0].toString(),
      account[1].toString(),
      account[2].toString(),
      account[3].toString(),
      account[4].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': [id, until, editKey, viewKey, locationId],
    };
  }
}
