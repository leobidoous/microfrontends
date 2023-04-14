import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity with EquatableMixin {
  NotificationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.route,
    required super.action,
    required super.date,
    required super.actionId,
    required super.read,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      route: map['route'] ?? '',
      action: map['action'] ?? '',
      date: DateFormat.tryParseOrDateNow(map['date'].toString()),
      actionId: map['actionId'] ?? '',
      read: map['read'] ?? '',
    );
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      route: entity.route,
      action: entity.action,
      date: entity.date,
      actionId: entity.actionId,
      read: entity.read,
    );
  }

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  NotificationEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'title': title,
      'description': description,
      'route': route,
      'action': action,
      'date': date,
      'actionId': actionId,
      'read': read,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        route,
        action,
        date,
        actionId,
        read,
      ];

  @override
  bool? get stringify => true;
}
