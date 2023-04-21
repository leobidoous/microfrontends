import 'dart:convert';
import 'package:core/core.dart';
import '../../../domain/entities/dashboard/history_entity.dart';

class HistoryModel extends HistoryEntity with EquatableMixin {
  HistoryModel({
    required super.id,
    required super.pagoEm,
    required super.saidaAte,
    required super.valorPago,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      pagoEm: DateFormat.tryParseOrDateNow(map['pagoEm']),
      saidaAte: DateFormat.tryParseOrDateNow(map['saidaAte']),
      valorPago: map['valorPago'],
    );
  }

  factory HistoryModel.fromEntity(HistoryEntity entity) {
    return HistoryModel(
      id: entity.id,
      pagoEm: entity.pagoEm,
      saidaAte: entity.saidaAte,
      valorPago: entity.valorPago,
    );
  }

  factory HistoryModel.fromJson(String source) =>
      HistoryModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  HistoryEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'pagoEm': pagoEm,
      'saidaAte': saidaAte,
      'valorPago': valorPago,
    };
  }

  @override
  List<Object?> get props => [
        id,
        pagoEm,
        saidaAte,
        valorPago,
      ];

  @override
  bool? get stringify => true;
}
