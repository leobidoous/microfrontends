import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RechargeProgress extends StatelessWidget {
  const RechargeProgress({super.key, required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: context.theme.borderRadiusSM,
      child: LinearProgressIndicator(
        value: percent / 100,
        minHeight: 2,
        backgroundColor: AppColorsBase.neutrla1,
        color: context.colorScheme.primary,
      ),
    );
  }
}
