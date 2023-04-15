import 'package:core/core.dart';
import 'package:flutter/material.dart';


class CouponRegistrationStatus extends StatelessWidget {
  //This widget receives values ​​in cents. Must be converted to real
  final double min;
  final double max;
  final double actual;
  final TextStyle? textStyle;

  const CouponRegistrationStatus({
    super.key,
    this.textStyle,
    this.min = 0,
    required this.max,
    required this.actual,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          NumberFormat.toCurrency(actual / 100),
          style: textStyle ?? context.textTheme.bodyMedium,
        ),
        Spacing.sm.horizontal,
        Expanded(
          child: ClipRRect(
            borderRadius: context.theme.borderRadiusMD,
            child: LinearProgressIndicator(
              value: actual <= 0 || max <= 0 ? 0 : actual / max,
              color: AppColorsBase.success2,
              backgroundColor: AppColorsBase.grey3,
              minHeight: const Spacing(1).value.responsiveHeight,
            ),
          ),
        ),
        Spacing.sm.horizontal,
        Text(
          NumberFormat.toCurrency(max / 100),
          style: textStyle ?? context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
