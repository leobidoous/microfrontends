import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction_category_entity.dart';

class TransactionCategoryModel 
  extends TransactionCategoryEntity with EquatableMixin {

  TransactionCategoryModel({
    required super.description,
    required super.name,
  });

  factory TransactionCategoryModel.fromMap(Map<String, dynamic> map) {
    return TransactionCategoryModel(
      description: map['description'] ?? '',
      name: map['name'] ?? '',
    );
  }

  factory TransactionCategoryModel.fromEntity(TransactionCategoryEntity entity) {
    return TransactionCategoryModel(  
      description: entity.description,
      name: entity.name,
    );
  }

  factory TransactionCategoryModel.fromJson(String source) => 
     TransactionCategoryModel.fromMap(json.decode(source));

  String get toJason => json.encode(toMap);

   Map<String, dynamic> get toMap {
    return {
      'description': description,
      'name': name,
    };
  }
  
  @override
  List<Object?> get props => [
    description,
    name,
  ];

  @override
  bool? get stringify => true;

}