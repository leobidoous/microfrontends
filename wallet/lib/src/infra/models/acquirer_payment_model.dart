import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/acquirer_payment_entity.dart';

class AcquirerPaymentModel extends AcquirerPaymentEntity with EquatableMixin {
  AcquirerPaymentModel({
    required super.chave,
    required super.cnpj,
    required super.dataEmissao,
    required super.model,
    required super.month,
    required super.qrCode,
    required super.state,
    required super.status,
    required super.url,
    required super.year,
    required super.total,
  });

  factory AcquirerPaymentModel.fromMap(Map<String, dynamic> map) {
    return AcquirerPaymentModel(
      chave: map['chave']?.toString() ?? '',
      cnpj: map['cnpj']?.toString() ?? '',
      dataEmissao: map['dataEmissao']?.toString() ?? '',
      model: map['model']?.toString() ?? '',
      month: map['month']?.toString() ?? '',
      qrCode: map['qrCode']?.toString() ?? '',
      state: map['state']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      url: map['url']?.toString() ?? '',
      year: map['year']?.toString() ?? '',
      total: map['total']?.toString() ?? '',
    );
  }

  factory AcquirerPaymentModel.fromEntity(AcquirerPaymentEntity entity) {
    return AcquirerPaymentModel(
      chave: entity.chave,
      cnpj: entity.cnpj,
      dataEmissao: entity.dataEmissao,
      model: entity.model,
      month: entity.month,
      qrCode: entity.qrCode,
      state: entity.state,
      status: entity.status,
      url: entity.url,
      year: entity.year,
      total: entity.total,
    );
  }

  String get formatedKey {
    final exp = RegExp(r'\d{' '${4}' '}');
    final matches = exp.allMatches(chave);
    final list = matches.map((m) => m.group(0));
    return list.join(' ');
  }

  String get nCoupon {
    try {
      return chave.split('').reversed.join().substring(0, 9);
    } catch (e) {
      return chave;
    }
  }

  factory AcquirerPaymentModel.fromJson(String source) =>
      AcquirerPaymentModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  AcquirerPaymentEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'chave': chave,
      'cnpj': cnpj,
      'dataEmissao': dataEmissao,
      'model': model,
      'month': month,
      'qrCode': qrCode,
      'state': state,
      'status': status,
      'url': url,
      'year': year,
      'total': total,
    };
  }

  @override
  List<Object?> get props => [
        chave,
        cnpj,
        dataEmissao,
        model,
        month,
        qrCode,
        state,
        status,
        url,
        year,
        total,
      ];

  @override
  bool? get stringify => true;
}
