import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/entities/dashboard/items_ticket_history_entity.dart';
import 'shopping_name_model.dart';

class ItemTicketHistoryModel extends ItemTicketHistoryEntity
    with EquatableMixin {
  ItemTicketHistoryModel({
    required super.createdAt,
    required super.data,
    required super.hora,
    required super.tipo,
    required super.valor,
    required super.name,
    required super.valueSaved,
  });

  factory ItemTicketHistoryModel.fromMap(Map<String, dynamic> map) {
    return ItemTicketHistoryModel(
      createdAt: DateFormat.tryParseOrDateNow(map['createdAt']),
      data: map['data'],
      hora: map['hora'],
      tipo: map['tipo'],
      valor: map['valor'],
      name: ShoppingNameModel.fromMap(map['Mall'] ?? {}),
      valueSaved: map['valor_economizado'],
    );
  }

  factory ItemTicketHistoryModel.fromEntity(ItemTicketHistoryEntity entity) {
    return ItemTicketHistoryModel(
      createdAt: entity.createdAt,
      data: entity.data,
      hora: entity.hora,
      tipo: entity.tipo,
      valor: entity.valor,
      name: entity.name,
      valueSaved: entity.valueSaved,
    );
  }

  factory ItemTicketHistoryModel.fromJson(String source) =>
      ItemTicketHistoryModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  ItemTicketHistoryEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'createdAt': createdAt,
      'data': data,
      'hora': hora,
      'tipo': tipo,
      'valor': valor,
      'Mall': name,
      'valor_economizado': valueSaved,
    };
  }

  @override
  List<Object?> get props => [
        createdAt,
        data,
        hora,
        tipo,
        valor,
        name,
        valueSaved,
      ];

  @override
  bool? get stringify => true;
}
