import 'dart:io';

class UniqueCouponEntity {
  final String key;
  double? value;
  final File file;

  UniqueCouponEntity({
    required this.key,
    this.value,
    required this.file,
  });
}
