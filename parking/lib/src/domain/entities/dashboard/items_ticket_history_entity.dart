import 'shopping_name_entity.dart';

class ItemTicketHistoryEntity {
  const ItemTicketHistoryEntity({
    this.data,
    this.hora,
    this.valor,
    this.tipo,
    this.createdAt,
    required this.name,
    required this.valueSaved,
  });

  final String? data;
  final String? hora;
  final String? valor;
  final String? tipo;
  final DateTime? createdAt;
  final ShoppingNameEntity? name;
  final String? valueSaved;
}
