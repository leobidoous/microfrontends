import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/balance_entity.dart';

class BalanceModel extends BalanceEntity with EquatableMixin {

  BalanceModel({
    required super.available, 
    required super.current,
  });

  factory BalanceModel.fromMap(Map<String, dynamic> map) {
     return BalanceModel(
      available: map['available'] ?? '',
      current: map['current'] ?? '',
    );
  }

  factory BalanceModel.fromEntity(BalanceEntity entity) {
    return BalanceModel(
       available: entity.available,
       current: entity.current,
    );
  }

  factory BalanceModel.fromjson(String source) =>
    BalanceModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  BalanceModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'available': available,
      'current': current,
    };
  }

  @override
  List<Object?> get props => [
    available, 
    current,
  ];

  @override
  bool? get stringify => true;

}