import 'company_entity.dart';
import 'person_entity.dart';

class SellerEntity {
  final CompanyEntity company;
  final PersonEntity person;
  final String displayName;
  final String cnpj;
  final String cpf;
  final String id;

  SellerEntity({
    required this.company,
    required this.displayName,
    required this.person,
    required this.id,
    required this.cnpj,
    required this.cpf,
  });
}
