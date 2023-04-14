import '../enums/transaction_method.dart';
import '../enums/transaction_type.dart';
import 'acquirer_payment_entity.dart';
import 'order_entity.dart';
import 'seller_entity.dart';

class TransactionEntity {
  final String id;
  final DateTime updatedAt;
  final String paymentProcessor;
  final DateTime insertedAt;
  final SellerEntity seller;
  final TransactionMethod method;
  final double additionCents;
  final String status;
  final double discountCents;
  final String refundReason;
  final DateTime confirmedAt;
  final double subtotalCents;
  final double totalCents;
  final TransactionType type;
  final OrderEntity order;
  final AcquirerPaymentEntity acquirerPayment;

  TransactionEntity({
    required this.id,
    required this.updatedAt,
    required this.paymentProcessor,
    required this.insertedAt,
    required this.seller,
    required this.method,
    required this.additionCents,
    required this.status,
    required this.discountCents,
    required this.refundReason,
    required this.confirmedAt,
    required this.subtotalCents,
    required this.totalCents,
    required this.type,
    required this.order,
    required this.acquirerPayment,
  });
}
