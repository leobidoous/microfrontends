import 'package:flutter/material.dart';

import '../../responsive/responsive_extension.dart';

///
/// Default app spacing sizes, considering responsiveness.
///
enum Spacing {
  /// Extra small = 4
  xxs(4),

  /// Extra small = 8
  xs(8),

  /// Extra medium = 12
  xm(12),

  /// Small = 16
  sm(16),

  /// Medium = 24
  md(24),

  /// Large = 32
  lg(32),

  /// Extra large = 40
  xl(40),

  /// Extra large = 48
  xxl(48),

  /// Extra large = 64
  xxxl(64);

  /// Raw double value, without considering responsiveness.
  final double value;

  /// Default [Spacing] constructor
  const Spacing(this.value);
}

///
/// Add extension methods to [Spacing] handle responsiveness.
///
extension SpacingExt on Spacing {
  /// Current value with [responsiveWidth] extension
  double get width => value.responsiveWidth;

  /// Current value with [responsiveHeight] extension
  double get height => value.responsiveHeight;

  /// Builds a [SizedBox] with vertical spacing (using responsiveHeight)
  SizedBox get vertical => SizedBox(height: value.responsiveHeight);

  /// Builds a [SizedBox] with horizontal spacing (using responsiveWidth)
  SizedBox get horizontal => SizedBox(width: value.responsiveWidth);
}
