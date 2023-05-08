import 'transaction_breakdown_entity.dart';
import 'transaction_creditcarddata_entity.dart';

class GigDataEntity {
  
  GigDataEntity({
    required this.breakdown,
    required this.collectedAt,
    required this.creditCardData,
    required this.distance,
    required this.dropoffAddress,
    required this.dropoffAt,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.merchantType,
    required this.paymentMethod,
    required this.pickupAddress,
    required this.pickupAt,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.requestAt,
    required this.vehicleType,
  });
  
  final List<TransactionBreakdownEntity> breakdown;
  final String collectedAt;
  final TransactionCreditcarddataEntity creditCardData;
  final double distance;
  final String dropoffAddress;
  final String dropoffAt;
  final String dropoffLatitude;
  final String dropoffLongitude;
  final String merchantType;
  final String paymentMethod;
  final String pickupAddress;
  final String pickupAt;
  final String pickupLatitude;
  final String pickupLongitude;
  final String requestAt;
  final String vehicleType;

}
