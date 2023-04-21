import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/entities/ticket/history_ticket_entity.dart';
import 'mall_model.dart';

class HistoryTicketModel extends HistoryTicketEntity with EquatableMixin {
  HistoryTicketModel({
    super.idMall,
    super.data,
    super.hora,
    super.valorEconomizado,
    super.tipo,
    super.createdAt,
    super.mall,
  });

  factory HistoryTicketModel.fromEntity(HistoryTicketEntity entity) {
    return HistoryTicketModel(
      idMall: entity.idMall,
      data: entity.data,
      hora: entity.hora,
      valorEconomizado: entity.valorEconomizado,
      tipo: entity.tipo,
      createdAt: entity.createdAt,
      mall: entity.mall,
    );
  }

  factory HistoryTicketModel.fromJson(String source) =>
      HistoryTicketModel.fromMap(json.decode(source));

  factory HistoryTicketModel.fromMap(Map<String, dynamic> map) {
    return HistoryTicketModel(
      idMall: map['id_mall'] ?? 0,
      data: map['data'],
      hora: map['hora'],
      valorEconomizado: map['valor_economizado'] ?? '',
      tipo: map['tipo'] ?? '',
      createdAt: DateFormat.tryParseOrDateNow(map['created_at']),
      mall: MallModel.fromMap(map['Mall']),
    );
  }

  String get toJson => json.encode(toMap);

  HistoryTicketEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id_mall': idMall,
      'data': data,
      'hora': hora,
      'valor_economizado': valorEconomizado,
      'tipo': tipo,
      'created_at': createdAt,
      'Mall': mall,
    };
  }

  @override
  List<Object?> get props => [
        idMall,
        data,
        hora,
        valorEconomizado,
        tipo,
        createdAt,
        mall,
      ];

  @override
  bool? get stringify => true;
}
