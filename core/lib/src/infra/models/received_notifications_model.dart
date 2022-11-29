import 'dart:convert';

import '../../../core.dart';

class ReceivedNotificationModel extends ReceivedNotificationEntity
    with EquatableMixin {
  ReceivedNotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.payload,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
    };
  }

  factory ReceivedNotificationModel.fromMap(Map<String, dynamic> map) {
    return ReceivedNotificationModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
    );
  }

  factory ReceivedNotificationModel.fromEntity(
    ReceivedNotificationEntity entity,
  ) {
    return ReceivedNotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      payload: entity.payload,
    );
  }

  String toJson() => json.encode(toMap());
  ReceivedNotificationEntity toEntity() => this;

  factory ReceivedNotificationModel.fromJson(String source) =>
      ReceivedNotificationModel.fromMap(
        json.decode(source),
      );

  @override
  List<Object?> get props => [id, title, body, payload];

  @override
  bool? get stringify => true;
}
