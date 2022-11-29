import 'dart:convert';

import '../../../core.dart';

class SharepointModel extends SharepointEntity with EquatableMixin {
  SharepointModel({
    required super.token,
    required super.timeToExpire,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': token,
      'expires_in': timeToExpire,
    };
  }

  SharepointEntity toEntity() => this;

  factory SharepointModel.fromMap(Map<String, dynamic> map) {
    return SharepointModel(
      token: map['access_token'],
      timeToExpire: map['expires_in'],
    );
  }

  factory SharepointModel.fromEntiy(SharepointEntity entity) {
    return SharepointModel(
      token: entity.token,
      timeToExpire: entity.timeToExpire,
    );
  }

  String toJson() => json.encode(toMap());

  factory SharepointModel.fromJson(String source) =>
      SharepointModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [token, timeToExpire];

  @override
  bool? get stringify => true;
}
