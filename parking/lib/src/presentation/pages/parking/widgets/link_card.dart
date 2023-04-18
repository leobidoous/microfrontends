import 'dart:math' as math;

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/enums/link_card_type_enum.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({super.key, required this.arguments, required this.isEnabled});

  final dynamic Function(LinkCardType)? arguments;
  final bool Function(LinkCardType) isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: const Spacing(30).value,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: const Spacing(2).value),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: LinkCardType.values.length,
        separatorBuilder: (_, __) => Spacing.sm.horizontal,
        itemBuilder: (_, index) => _CardWidget(
          type: LinkCardType.values[index],
          arguments: arguments,
          isEnabled: isEnabled,
        ),
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    required this.type,
    required this.arguments,
    required this.isEnabled,
  });

  final dynamic Function(LinkCardType)? arguments;
  final bool Function(LinkCardType) isEnabled;
  final LinkCardType type;

  @override
  Widget build(context) {
    return Opacity(
      opacity: isEnabled(type) ? 1 : .5,
      child: Material(
        color: type.color,
        borderRadius: context.theme.borderRadiusMD,
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: type.nav(arguments),
            borderRadius: context.theme.borderRadiusMD,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: const Spacing(17.5).value,
                maxWidth: const Spacing(17.5).value,
              ),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  _BackgroundStyle(type: type),
                  Positioned(
                    right: const Spacing(2).value / 2,
                    bottom: const Spacing(2).value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: type.color,
                        boxShadow: [context.theme.shadowLightmodeLevel1],
                        borderRadius: context.theme.borderRadiusSM,
                      ),
                      padding: EdgeInsets.all(const Spacing(1.5).value),
                      child: Icon(
                        CoreIcons.rightOutline,
                        size: AppFontSize.iconButton.value,
                        color: context.colorScheme.background,
                      ),
                    ),
                  ),
                  _buildCardText,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildCardText {
    return LocalTheme.dark(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            const Spacing(1).value,
            const Spacing(5).value,
            const Spacing(1).value,
            const Spacing(6).value,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Text(
                  type.texts(context).first,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ),
              Spacing.xs.vertical,
              Flexible(
                child: Text(
                  type.texts(context).last,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _BackgroundStyle extends StatelessWidget {
  const _BackgroundStyle({required this.type});

  final LinkCardType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LinkCardType.ticket:
        return Stack(
          children: [
            Positioned(
              top: -20.0,
              left: -40.0,
              child: Icon(
                CoreIcons.scancodeOutline,
                size: 112.0,
                color: context.colorScheme.background.withOpacity(0.26),
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 0,
              child: Icon(
                CoreIcons.barCode,
                size: 80.0,
                color: context.colorScheme.background.withOpacity(0.26),
              ),
            ),
          ],
        );
      case LinkCardType.desk:
        return Stack(
          children: [
            Positioned(
              top: -10.0,
              left: -10.0,
              child: Icon(
                CoreIcons.informationCircleOutline,
                size: 98.0,
                color: context.colorScheme.background.withOpacity(0.26),
              ),
            ),
            Positioned(
              bottom: const Spacing(4).value,
              right: -14,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.background.withOpacity(0.26),
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.background.withOpacity(0.8),
                      context.colorScheme.background.withOpacity(.05),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: const GradientRotation(math.pi - 10),
                    stops: const [.2, .7, .9],
                  ),
                ),
                child: SizedBox.fromSize(
                  size: Size(const Spacing(10).value, const Spacing(10).value),
                ),
              ),
            ),
            Positioned(
              bottom: -const Spacing(5).value,
              left: -const Spacing(3.0).value,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.background.withOpacity(0.26),
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.background,
                      context.colorScheme.background.withOpacity(.05),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: const GradientRotation(math.pi - 4.2),
                    stops: const [.2, .7, .9],
                  ),
                ),
                child: SizedBox.fromSize(
                  size: Size(const Spacing(10).value, const Spacing(10).value),
                ),
              ),
            ),
          ],
        );

      case LinkCardType.wallet:
        return Stack(
          children: [
            Positioned(
              top: 4.0,
              right: -20.0,
              child: Icon(
                Icons.monetization_on_outlined,
                size: 98.0,
                color: context.colorScheme.background.withOpacity(0.26),
              ),
            ),
            Positioned(
              bottom: 36.0,
              left: -50,
              child: Icon(
                CoreIcons.money,
                size: 64.0,
                color: context.colorScheme.background.withOpacity(0.26),
              ),
            ),
          ],
        );

      case LinkCardType.vehicle:
        return Stack(
          children: [
            Positioned(
              top: 20.0,
              right: -10.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.background.withOpacity(.4),
                  borderRadius: context.theme.borderRadiusMD,
                ),
                child: SizedBox.fromSize(
                  size: const Size(48.0, 32.0),
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: -20,
              child: Icon(
                CoreIcons.carSide,
                size: 98.0,
                color: context.colorScheme.background.withOpacity(.4),
              ),
            ),
          ],
        );
    }
  }
}
