import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/order_entity.dart';
import 'order_item_model.dart';
import 'seller_model.dart';

class OrderModel extends OrderEntity with EquatableMixin {
  OrderModel({
    required super.id,
    required super.additionCents,
    required super.applicationId,
    required super.totalCents,
    required super.feePercent,
    required super.methods,
    required super.discountCents,
    required super.customerData,
    required super.customer,
    required super.type,
    required super.sellerId,
    required super.customerId,
    required super.contactId,
    required super.sessionId,
    required super.subtotalCents,
    required super.updatedAt,
    required super.expirationDate,
    required super.maxInstallments,
    required super.observation,
    required super.externalId,
    required super.shippingCents,
    required super.marketplaceId,
    required super.insertedAt,
    required super.externalUserId,
    required super.shippingAddress,
    required super.location,
    required super.subscriptionId,
    required super.feeAmountCents,
    required super.items,
    required super.status,
    required super.seller,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      additionCents: map['additionCents'] ?? 0,
      applicationId: map['applicationId'] ?? '',
      totalCents: map['totalCents'] ?? 0,
      feePercent: map['feePercent'] ?? '',
      methods: map['methods']?.cast<String>() ?? [],
      discountCents: map['discountCents'] ?? 0,
      customerData: CustomerModel.fromMap(map['customerData'] ?? {}),
      customer: CustomerModel.fromMap(map['customer'] ?? {}),
      type: map['type'] ?? '',
      sellerId: map['sellerId'] ?? '',
      customerId: map['customerId'] ?? '',
      contactId: map['contactId'] ?? '',
      sessionId: map['sessionId'] ?? '',
      subtotalCents: map['subtotalCents'] ?? 0,
      updatedAt: map['updatedAt'] ?? '',
      expirationDate: map['expirationDate'] ?? '',
      maxInstallments: map['maxInstallments'] ?? 0,
      observation: map['observation'] ?? '',
      externalId: map['externalId'] ?? '',
      shippingCents: map['shippingCents'] ?? 0,
      marketplaceId: map['marketplaceId'] ?? '',
      insertedAt: map['insertedAt'] ?? '',
      externalUserId: map['externalUserId'] ?? '',
      shippingAddress: BillingAddressModel.fromMap(
        map['shippingAddress'] ?? {},
      ),
      location: map['location'] ?? '',
      subscriptionId: map['subscriptionId'] ?? '',
      feeAmountCents: map['feeAmountCents'] ?? '',
      items: ((map['items'] ?? []) as List)
          .map((e) => OrderItemModel.fromMap(e))
          .toList(),
      status: map['status'] ?? '',
      seller: SellerModel.fromMap(map['seller'] ?? {}),
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      additionCents: entity.additionCents,
      applicationId: entity.applicationId,
      totalCents: entity.totalCents,
      feePercent: entity.feePercent,
      methods: entity.methods,
      discountCents: entity.discountCents,
      customerData: entity.customerData,
      customer: entity.customer,
      type: entity.type,
      sellerId: entity.sellerId,
      customerId: entity.customerId,
      contactId: entity.contactId,
      sessionId: entity.sessionId,
      subtotalCents: entity.subtotalCents,
      updatedAt: entity.updatedAt,
      expirationDate: entity.expirationDate,
      maxInstallments: entity.maxInstallments,
      observation: entity.observation,
      externalId: entity.externalId,
      shippingCents: entity.shippingCents,
      marketplaceId: entity.marketplaceId,
      insertedAt: entity.insertedAt,
      externalUserId: entity.externalUserId,
      shippingAddress: entity.shippingAddress,
      location: entity.location,
      subscriptionId: entity.subscriptionId,
      feeAmountCents: entity.feeAmountCents,
      items: entity.items,
      status: entity.status,
      seller: entity.seller,
    );
  }

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  OrderEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'additionCents': additionCents,
      'applicationId': applicationId,
      'totalCents': totalCents,
      'feePercent': feePercent,
      'methods': methods,
      'discountCents': discountCents,
      'customerData': CustomerModel.fromEntity(customerData).toMap,
      'customer': CustomerModel.fromEntity(customer).toMap,
      'type': type,
      'sellerId': sellerId,
      'customerId': customerId,
      'contactId': contactId,
      'sessionId': sessionId,
      'subtotalCents': subtotalCents,
      'updatedAt': updatedAt,
      'expirationDate': expirationDate,
      'maxInstallments': maxInstallments,
      'observation': observation,
      'externalId': externalId,
      'shippingCents': shippingCents,
      'marketplaceId': marketplaceId,
      'insertedAt': insertedAt,
      'externalUserId': externalUserId,
      'shippingAddress': BillingAddressModel.fromEntity(shippingAddress).toMap,
      'location': location,
      'subscriptionId': subscriptionId,
      'feeAmountCents': feeAmountCents,
      'items': items,
      'status': status,
      'seller': SellerModel.fromEntity(seller).toMap,
    };
  }

  @override
  List<Object?> get props => [
        id,
        additionCents,
        applicationId,
        totalCents,
        feePercent,
        methods,
        discountCents,
        customerData,
        customer,
        type,
        sellerId,
        customerId,
        contactId,
        sessionId,
        subtotalCents,
        updatedAt,
        expirationDate,
        maxInstallments,
        observation,
        externalId,
        shippingCents,
        marketplaceId,
        insertedAt,
        externalUserId,
        shippingAddress,
        location,
        subscriptionId,
        feeAmountCents,
        items,
        status,
        seller,
      ];

  @override
  bool? get stringify => true;
}
