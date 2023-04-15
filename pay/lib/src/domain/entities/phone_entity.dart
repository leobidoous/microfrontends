import '../enums/operator_type_enum.dart';

class PhoneEntity {
  final String number;
  final OperatorType operator;

  PhoneEntity({required this.number, required this.operator});
}
