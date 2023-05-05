import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/entities/ticket/history_ticket_entity.dart';
import '../dashboard/status_class_model.dart';
import 'mall_model.dart';

class HistoryTicketModel extends HistoryTicketEntity with EquatableMixin {
  HistoryTicketModel({
    super.isPlate,
    super.ticket,
    super.valor,
    super.valorEconomizado,
    super.tipo,
    super.createdAt,
    super.mall,
  });

  factory HistoryTicketModel.fromEntity(HistoryTicketEntity entity) {
    return HistoryTicketModel(
      valorEconomizado: entity.valorEconomizado,
      valor: entity.valor,
      isPlate: entity.isPlate,
      ticket: entity.ticket,
      tipo: entity.tipo,
      createdAt: entity.createdAt,
      mall: entity.mall,
    );
  }

  factory HistoryTicketModel.fromJson(String source) =>
      HistoryTicketModel.fromMap(json.decode(source));

  factory HistoryTicketModel.fromMap(Map<String, dynamic> map) {
    return HistoryTicketModel(
      valorEconomizado: (map['valor_economizado'] as int).toDouble(),
      valor: (map['valor'] as int).toDouble(),
      isPlate: map['data'],
      ticket: map['hora'],
      tipo: StatusClassModel.fromMap(map['tipo']),
      createdAt: DateFormat.tryParseOrDateNow(map['created_at']),
      mall: MallModel.fromMap(map['Mall']),
    );
  }

  String get toJson => json.encode(toMap);

  HistoryTicketEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'valor_economizado': valorEconomizado,
      'valor': valor,
      'is_plate': isPlate,
      'ticket': ticket,
      'tipo': tipo,
      'created_at': createdAt,
      'Mall': mall,
    };
  }

  @override
  List<Object?> get props => [
        valorEconomizado,
        valor,
        isPlate,
        ticket,
        tipo,
        createdAt,
        mall,
      ];

  @override
  bool? get stringify => true;
}
