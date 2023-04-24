import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/billing_address_entity.dart';
import '../../domain/entities/customer_entity.dart';
import 'billing_address_model.dart';

class CustomerModel extends CustomerEntity with EquatableMixin {
  CustomerModel({
    required super.address,
    required super.birthDate,
    required super.cnpj,
    required super.cpf,
    required super.email,
    required super.emailVerifiedAt,
    required super.id,
    required super.marketplaceId,
    required super.name,
    required super.phone,
    required super.phoneVerifiedAt,
    required super.termAcceptedAt,
    required super.termVersion,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      address: BillingAddressModel.fromMap(map['address'] ?? {}),
      birthDate: map['birthDate'] ?? '',
      cnpj: map['cnpj'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
      emailVerifiedAt: map['emailVerifiedAt'] ?? '',
      id: map['id'] ?? '',
      marketplaceId: map['marketplaceId'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      phoneVerifiedAt: map['phoneVerifiedAt'] ?? '',
      termAcceptedAt: map['termAcceptedAt'] ?? '',
      termVersion: map['termVersion'] ?? '',
    );
  }

  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      address: entity.address,
      birthDate: entity.birthDate,
      cnpj: entity.cnpj,
      cpf: entity.cpf,
      email: entity.email,
      emailVerifiedAt: entity.emailVerifiedAt,
      id: entity.id,
      marketplaceId: entity.marketplaceId,
      name: entity.name,
      phone: entity.phone,
      phoneVerifiedAt: entity.phoneVerifiedAt,
      termAcceptedAt: entity.termAcceptedAt,
      termVersion: entity.termVersion,
    );
  }

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  CustomerModel copyWith({
    BillingAddressEntity? address,
    String? birthDate,
    String? cnpj,
    String? cpf,
    String? email,
    String? emailVerifiedAt,
    String? id,
    String? marketplaceId,
    String? name,
    String? phone,
    String? phoneVerifiedAt,
    String? termAcceptedAt,
    String? termVersion,
  }) {
    return CustomerModel(
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      cnpj: cnpj ?? this.cnpj,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      id: id ?? this.id,
      marketplaceId: marketplaceId ?? this.marketplaceId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      termAcceptedAt: termAcceptedAt ?? this.termAcceptedAt,
      termVersion: termVersion ?? this.termVersion,
    );
  }

  String get toJson => json.encode(toMap);

  CustomerEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'address': BillingAddressModel.fromEntity(address).toMap,
      'birthDate': birthDate,
      'cnpj': cnpj,
      'cpf': cpf,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'id': id,
      'marketplaceId': marketplaceId,
      'name': name,
      'phone': phone,
      'phoneVerifiedAt': phoneVerifiedAt,
      'termAcceptedAt': termAcceptedAt,
      'termVersion': termVersion,
    };
  }

  Map<String, dynamic> get toUpdateCustomerMap {
    return {
      'address': BillingAddressModel.fromEntity(address).toMap,
      'birthDate': birthDate,
      'email': email,
      'name': name,
    };
  }

  Map<String, dynamic> get toNewCustomerMap {
    return {
      'address': BillingAddressModel.fromEntity(address).toMap,
      'cpf': cpf,
      'name': name,
      'termAcceptedAt': termAcceptedAt,
      'termVersion': '1.0.1',
    };
  }

  @override
  List<Object?> get props => [
        address,
        birthDate,
        cnpj,
        cpf,
        email,
        emailVerifiedAt,
        id,
        marketplaceId,
        name,
        phone,
        phoneVerifiedAt,
        termAcceptedAt,
        termVersion,
      ];

  @override
  bool? get stringify => true;
}
