import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GenShimmer extends StatelessWidget {
  const GenShimmer({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.background,
      highlightColor: context.colorScheme.primary,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: borderRadius ?? AppThemeBase.borderRadiusXSM,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
