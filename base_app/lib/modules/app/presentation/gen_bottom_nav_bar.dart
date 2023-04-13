import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/bottom_nav_bar_type_enum.dart';

class GenBottomNavBar extends StatefulWidget {
  final BottomNavBarType selected;
  const GenBottomNavBar({super.key, required this.selected});

  @override
  State<GenBottomNavBar> createState() => _GenBottomNavBarState();
}

class _GenBottomNavBarState extends State<GenBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: AppThemeBase.borderRadiusMD.topLeft,
          topRight: AppThemeBase.borderRadiusMD.topRight,
        ),
        border: Border.all(
          color: context.colorScheme.shadow,
          width: context.textTheme.lineHeightTight,
        ),
        boxShadow: [context.theme.shadowLightmodeLevel1],
      ),
      padding: EdgeInsets.all(const Spacing(2).value),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: BottomNavBarType.values
              .map((e) => Flexible(child: _bottomNavBarItem(e)))
              .toList(),
        ),
      ),
    );
  }

  Widget _bottomNavBarItem(BottomNavBarType item) {
    final isSelected = widget.selected == item;
    return InkWell(
      onTap: () {
        if (!isSelected) {
          late Object? args;
          switch (item) {
            case BottomNavBarType.wallet:
              args = false;
              break;
            case BottomNavBarType.profile:
              args = false;
              break;
            case BottomNavBarType.home:
              args = false;
              
              break;
            default:
              args = null;
              break;
          }
          if (Nav.to.canPop()) {
            Nav.to.pushReplacementNamed(item.route, arguments: args);
          } else {
            Nav.to.pushNamed(item.route, arguments: args);
          }
        }
      },
      child: LocalTheme.dark(
        builder: (context) {
          return Tooltip(
            message: item.name,
            verticalOffset: const Spacing(3.5).value.responsiveHeight,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: context.theme.borderRadiusSM,
            ),
            textStyle: context.textTheme.bodyMedium,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  item.asset,
                  height: const Spacing(2.5).value.responsiveHeight,
                  width: const Spacing(2.5).value.responsiveWidth,
                  color: isSelected
                      ? AppColorsBase.textButtonColor
                      : AppColorsBase.neutrla3,
                ),
                Spacing.xs.vertical,
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? AppColorsBase.textButtonColor
                        : AppColorsBase.neutrla3,
                    fontWeight: isSelected
                        ? FontWeight.w500
                        : context.textTheme.fontWeightLight,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
