import 'billing_address_entity.dart';

class CustomerEntity {
  final BillingAddressEntity address;
  final String birthDate;
  final String cnpj;
  final String cpf;
  final String email;
  final String emailVerifiedAt;
  final String id;
  final String marketplaceId;
  final String name;
  final String phone;
  final String phoneVerifiedAt;
  final String termAcceptedAt;
  final String termVersion;

  CustomerEntity({
    required this.address,
    required this.birthDate,
    required this.cnpj,
    required this.cpf,
    required this.email,
    required this.emailVerifiedAt,
    required this.id,
    required this.marketplaceId,
    required this.name,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.termAcceptedAt,
    required this.termVersion,
  });
}
