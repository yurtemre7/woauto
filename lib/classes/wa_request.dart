enum WaRequestStatus { pending, accepted, rejected }

class WaRequest {
  final String id;
  final String senderId;
  final String receiver;
  final WaRequestStatus status;

  WaRequest({
    required this.id,
    required this.senderId,
    required this.receiver,
    required this.status,
  });
}
