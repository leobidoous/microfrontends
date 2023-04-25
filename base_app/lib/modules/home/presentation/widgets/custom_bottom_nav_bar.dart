import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/bottom_nav_bar_type_enum.dart';
import '../controllers/home_controller.dart';

class CustomBottomNavBar extends StatefulWidget {
  final BottomNavBarType selected;
  const CustomBottomNavBar({super.key, required this.selected});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final controller = DM.i.get<HomeController>();
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
        switch (item) {
          case BottomNavBarType.search:
            Nav.to.pushNamed(item.route, forRoot: true);
            break;
          case BottomNavBarType.payment:
            Nav.to.pushNamed(item.route, forRoot: true);
            break;
          default:
            Nav.to.navigate(item.route);
            controller.onChangeMenuItem(item);
            break;
        }
      },
      child: LocalTheme.dark(
        builder: (context) {
          return Tooltip(
            message: item.name,
            verticalOffset: const Spacing(5).value.responsiveHeight,
            excludeFromSemantics: true,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: context.theme.borderRadiusSM,
            ),
            textStyle: context.textTheme.bodyMedium,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  item.asset,
                  size: const Spacing(2.5).value.responsiveHeight,
                  color: isSelected
                      ? context.colorScheme.primary
                      : AppColorsBase.neutrla3,
                ),
                Spacing.xs.vertical,
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? context.colorScheme.primary
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
