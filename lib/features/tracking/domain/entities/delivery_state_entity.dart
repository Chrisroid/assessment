enum DeliveryStatus {
  pickingUp,
  onDelivery,
  arrived,
  delivered
}

class DeliveryStateEntity {
  final String orderId;
  final String courierName;
  final String courierRole;
  final String courierAvatarUrl;
  final String etaMessage;
  final DeliveryStatus status;
  final DateTime estimatedTime;
  final String destinationAddress;

  DeliveryStateEntity({
    required this.orderId,
    required this.courierName,
    required this.courierRole,
    required this.courierAvatarUrl,
    required this.etaMessage,
    required this.status,
    required this.estimatedTime,
    required this.destinationAddress,
  });
}
