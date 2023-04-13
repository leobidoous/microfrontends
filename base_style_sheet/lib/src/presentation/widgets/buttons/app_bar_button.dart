import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isEnabled = true,
  });

  final Function() onTap;
  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : .5,
      child: Semantics(
        button: isEnabled,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: AppThemeBase.borderRadiusSM,
          child: Padding(
            padding: EdgeInsets.all(const Spacing(2).value),
            child: SizedBox(
              width: const Spacing(3).value.responsiveWidth,
              height: const Spacing(3).value.responsiveHeight,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
