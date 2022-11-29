class ReceivedNotificationEntity {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
