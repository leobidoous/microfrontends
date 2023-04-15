import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/dashboard/analysis_entity.dart';

class AnalysisModel extends AnalysisEntity with EquatableMixin {
  AnalysisModel({
    required super.message,
    required super.amountDue,
    required super.test,
  });

  factory AnalysisModel.fromMap(Map<String, dynamic> map) {
    return AnalysisModel(
      message: map['message'] ?? '',
      amountDue: map['amountDue'] ?? '',
      test: map['test'] ?? '',
    );
  }

  factory AnalysisModel.fromEntity(AnalysisEntity entity) {
    return AnalysisModel(
      message: entity.message,
      amountDue: entity.amountDue,
      test: entity.test,
    );
  }

  factory AnalysisModel.fromJson(String source) =>
      AnalysisModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  AnalysisEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'message': message,
      'amountDue': amountDue,
      'test': test,
    };
  }

  @override
  List<Object?> get props => [
        message,
        amountDue,
        test,
      ];

  @override
  bool? get stringify => true;
}
