import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/dashboard/tickets_history_entity.dart';
import 'items_ticket_history_model.dart';

class TicketsHistoryModel extends TicketsHistoryEntity with EquatableMixin {
  TicketsHistoryModel({
    required super.count,
    required super.itemsTicketHistory,
  });

  factory TicketsHistoryModel.fromMap(Map<String, dynamic> map) {
    return TicketsHistoryModel(
      count: map['count'],
      itemsTicketHistory: (map['rows'] is List<dynamic>)
          ? map['rows']
          .map((element) => ItemTicketHistoryModel.fromMap(element))
          .toList()
          : null,
    );
  }

  factory TicketsHistoryModel.fromEntity(TicketsHistoryEntity entity) {
    return TicketsHistoryModel(
      count: entity.count,
      itemsTicketHistory: entity.itemsTicketHistory,
    );
  }

  factory TicketsHistoryModel.fromJson(String source) =>
      TicketsHistoryModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TicketsHistoryEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'count': count,
      'rows': itemsTicketHistory,
    };
  }

  @override
  List<Object?> get props => [
        count,
        itemsTicketHistory,
      ];

  @override
  bool? get stringify => true;
}
