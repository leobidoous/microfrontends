import 'package:core/core.dart';

import 'billing_address_entity.dart';
import 'order_item_entity.dart';
import 'seller_entity.dart';

class OrderEntity {
  final String id;
  final int additionCents;
  final String applicationId;
  final int totalCents;
  final String feePercent;
  final List<String> methods;
  final int discountCents;
  final CustomerEntity customerData;
  final CustomerEntity customer;
  final String type;
  final String sellerId;
  final String customerId;
  final String contactId;
  final String sessionId;
  final int subtotalCents;
  final String updatedAt;
  final String expirationDate;
  final int maxInstallments;
  final String observation;
  final String externalId;
  final int shippingCents;
  final String marketplaceId;
  final String insertedAt;
  final String externalUserId;
  final BillingAddressEntity shippingAddress;
  final String location;
  final String subscriptionId;
  final String feeAmountCents;
  final List<OrderItemEntity> items;
  final String status;
  final SellerEntity seller;

  OrderEntity({
    required this.id,
    required this.additionCents,
    required this.applicationId,
    required this.totalCents,
    required this.feePercent,
    required this.methods,
    required this.discountCents,
    required this.customerData,
    required this.customer,
    required this.type,
    required this.sellerId,
    required this.customerId,
    required this.contactId,
    required this.sessionId,
    required this.subtotalCents,
    required this.updatedAt,
    required this.expirationDate,
    required this.maxInstallments,
    required this.observation,
    required this.externalId,
    required this.shippingCents,
    required this.marketplaceId,
    required this.insertedAt,
    required this.externalUserId,
    required this.shippingAddress,
    required this.location,
    required this.subscriptionId,
    required this.feeAmountCents,
    required this.items,
    required this.status,
    required this.seller,
  });
}
