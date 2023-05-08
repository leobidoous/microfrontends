import 'link_entity.dart';

class InvestimentEntity {

  final double averageAcquisitionPrice;
  final double balanceGross;
  final double balanceNet;
  final String currency;
  final String id;
  final LinkEntity link;
  final String name;
  final String openDate;
  final double price;
  final double profit;
  final double quantity;
  final String subtype;
  final String type;
  
  InvestimentEntity({
    required this.averageAcquisitionPrice,
    required this.balanceGross,
    required this.balanceNet,
    required this.currency,
    required this.id,
    required this.link,
    required this.name,
    required this.openDate,
    required this.price,
    required this.profit,
    required this.quantity,
    required this.subtype,
    required this.type,
  });

}
