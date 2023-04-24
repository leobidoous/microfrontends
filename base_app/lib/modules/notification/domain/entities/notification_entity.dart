class NotificationEntity {
  final String id;
  final String title;
  final String description;
  final String route;
  final String action;
  final DateTime date;
  final String actionId;
  final bool read;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.route,
    required this.action,
    required this.actionId,
    required this.read,
  });
}
