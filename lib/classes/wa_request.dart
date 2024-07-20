import 'package:woauto/classes/wa_object.dart';

enum WaRequestStatus { pending, accepted, rejected }

class WaRequest extends WaObject {
  final String id;
  final String senderId;
  final String receiver;
  final WaRequestStatus status;

  WaRequest(
    super.recordModel, {
    required this.id,
    required this.senderId,
    required this.receiver,
    required this.status,
  });
}
