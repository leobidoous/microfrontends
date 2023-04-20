import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/delivery_options_entity.dart';

class DeliveryOptionsModel extends DeliveryOptionsEntity with EquatableMixin {
  DeliveryOptionsModel({
    required super.range,
    required super.rate,
    required super.rateString,
    required super.time,
  });

  factory DeliveryOptionsModel.fromMap(Map<String, dynamic> map) {
    return DeliveryOptionsModel(
      range: map['range'] ?? 0,
      rate: map['rate'] ?? 0,
      rateString: map['rateString'] ?? '',
      time: map['time'] ?? 0,
    );
  }

  factory DeliveryOptionsModel.fromEntity(DeliveryOptionsEntity entity) {
    return DeliveryOptionsModel(
      range: entity.range,
      rate: entity.rate,
      rateString: entity.rateString,
      time: entity.time,
    );
  }

  DeliveryOptionsModel copyWith({
    int? range,
    int? rate,
    String? rateString,
    int? time,
  }) {
    return DeliveryOptionsModel(
      range: range ?? this.range,
      rate: rate ?? this.rate,
      rateString: rateString ?? this.rateString,
      time: time ?? this.time,
    );
  }

  factory DeliveryOptionsModel.fromJson(String source) =>
      DeliveryOptionsModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  DeliveryOptionsEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'range': range,
      'rate': rate,
      'rateString': rateString,
      'time': time,
    };
  }

  @override
  List<Object?> get props => [
        range,
        rate,
        rateString,
        time,
      ];

  @override
  bool? get stringify => true;
}
