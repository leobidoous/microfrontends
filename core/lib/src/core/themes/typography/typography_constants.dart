import 'package:flutter/material.dart';

import '../responsive/responsive_extension.dart';

const String appFontFamily = 'Source Sans Pro';

enum AppFontWeight {
  bold(FontWeight.w700),
  medium(FontWeight.w600),
  regular(FontWeight.w400),
  light(FontWeight.w300);

  final FontWeight value;
  const AppFontWeight(this.value);
}

enum AppLineHeight {
  xs(0.5),
  sm(1),
  md(1.5),
  lg(2);

  final double value;
  const AppLineHeight(this.value);
}

enum AppFontSize {
  bodyLarge(16),
  bodyMedium(14),
  bodySmall(12),
  titleLarge(20),
  titleMedium(18),
  titleSmall(16),
  displayLarge(10),
  displayMedium(8),
  displaySmall(6),
  headlineLarge(28),
  headlineMedium(26),
  headlineSmall(24),
  labelLarge(16),
  labelMedium(14),
  labelSmall(12),
  iconButton(16);

  final int _value;
  const AppFontSize(this._value);
  double get value => _value.fontSize;
}
