import '../../domain/entities/postal_code_entity.dart';

class PostalCodeModel extends PostalCodeEntity {
  PostalCodeModel({
    required super.postalCode,
    required super.street,
    required super.complement,
    required super.district,
    required super.city,
    required super.ufCode,
    required super.ibge,
    required super.gia,
    required super.ddd,
    required super.siafi,
  });

  factory PostalCodeModel.fromMap(Map<String, dynamic> map) {
    return PostalCodeModel(
      postalCode: map['cep'] ?? '',
      street: map['logradouro'] ?? '',
      complement: map['complemento'] ?? '',
      district: map['bairro'] ?? '',
      city: map['localidade'] ?? '',
      ufCode: map['uf'] ?? '',
      ibge: map['ibge'] ?? '',
      gia: map['gia'] ?? '',
      ddd: map['ddd'] ?? '',
      siafi: map['siafi'] ?? '',
    );
  }

  factory PostalCodeModel.fromEntity(PostalCodeEntity entity) {
    return PostalCodeModel(
      postalCode: entity.postalCode,
      street: entity.street,
      complement: entity.complement,
      district: entity.district,
      city: entity.city,
      ufCode: entity.ufCode,
      ibge: entity.ibge,
      gia: entity.gia,
      ddd: entity.ddd,
      siafi: entity.siafi,
    );
  }

  PostalCodeEntity get toEntity => this;
}
