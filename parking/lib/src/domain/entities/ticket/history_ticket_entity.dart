import '../dashboard/status_class_entity.dart';
import 'mall_entity.dart';

class HistoryTicketEntity {
  const HistoryTicketEntity({
    this.valor,
    this.isPlate,
    this.ticket,
    this.valorEconomizado,
    this.tipo,
    this.createdAt,
    this.mall,
  });

  final double? valorEconomizado;
  final double? valor;
  final bool? isPlate;
  final String? ticket;
  final StatusClassEntity? tipo;
  final DateTime? createdAt;
  final MallEntity? mall;
}
