import 'package:pocketbase/pocketbase.dart';
import 'package:woauto/classes/wa_object.dart';

class WaCar extends WaObject {
  String id;
  String name;
  String yearOfManifacture;
  String userId;

  WaCar(
    super.recordModel, {
    required this.id,
    required this.name,
    required this.yearOfManifacture,
    required this.userId,
  });

  factory WaCar.fromRecord(RecordModel model) {
    return WaCar(
      model,
      id: model.id,
      name: model.data['name'],
      yearOfManifacture: model.data['baujahr'],
      userId: model.data['user'],
    );
  }
}
