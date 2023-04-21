import 'mall_entity.dart';

class HistoryTicketEntity {
  HistoryTicketEntity({
    this.idMall,
    this.data,
    this.hora,
    this.valorEconomizado,
    this.tipo,
    this.createdAt,
    this.mall,
  });

  final int? idMall;
  final String? data;
  final String? hora;
  final String? valorEconomizado;
  final String? tipo;
  final DateTime? createdAt;
  final MallEntity? mall;
}
