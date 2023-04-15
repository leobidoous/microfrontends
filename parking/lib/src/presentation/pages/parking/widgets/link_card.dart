part of 'parking_page.dart';

enum LinkCardType { ticket, desk, wallet, vehicle }

extension LinkCardTypeExt on LinkCardType {
  Color get color {
    switch (this) {
      case LinkCardType.ticket:
        return GenColors.danger;
      case LinkCardType.desk:
        return GenColors.primary;
      case LinkCardType.wallet:
        return GenColors.successDark;
      case LinkCardType.vehicle:
        return GenColors.warningDark;

      default:
        return GenColors.primary;
    }
  }

  List<String> texts(BuildContext context) {
    switch (this) {
      case LinkCardType.ticket:
        return [
          context.tr.ticketTitle,
          context.tr.ticketDescription,
        ];
      case LinkCardType.desk:
        return [
          context.tr.balconyTitle,
          context.tr.balconyDescription,
        ];
      case LinkCardType.wallet:
        return [
          context.tr.walletTitle,
          context.tr.walletDescription,
        ];
      case LinkCardType.vehicle:
        return [
          context.tr.vehicleTitle,
          context.tr.vehicleDescription,
        ];

      default:
        return ['', ''];
    }
  }

  List<IconData> icons(BuildContext context) {
    switch (this) {
      case LinkCardType.ticket:
        return [
          GenIcons.scancodeOutline,
          GenIcons.barCode,
        ];
      case LinkCardType.desk:
        return [
          GenIcons.informationCircleOutline,
          GenIcons.scancodeOutline,
        ];
      case LinkCardType.wallet:
        return [
          GenIcons.money,
          GenIcons.scancodeOutline,
        ];
      case LinkCardType.vehicle:
        return [
          GenIcons.carSide,
          GenIcons.scancodeOutline,
        ];

      default:
        return [
          GenIcons.scancodeOutline,
          GenIcons.scancodeOutline,
        ];
    }
  }

  Function get nav {
    switch (this) {
      case LinkCardType.ticket:
        return () => Nav.to.pushNamed(TicketRoutes.ticketTracking);
      case LinkCardType.desk:
        return () => Nav.to.pushNamed(GenDeskRoutes.root);
      case LinkCardType.wallet:
        return () => Nav.to.pushNamed(WalletRoutes.root);
      case LinkCardType.vehicle:
        return () => Nav.to.pushNamed(VehiclesRoutes.listVehicles);
      default:
        return () {};
    }
  }
}

class _LinkCard extends StatelessWidget {
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
        ),
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  final LinkCardType type;

  const _CardWidget({required this.type});

  @override
  Widget build(context) {
    return Material(
      color: type.color,
      borderRadius: context.theme.borderRadiusMD,
      child: InkWell(
        onTap: () => type.nav(),
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
                    GenIcons.rightOutline,
                    size: AppFontSize.iconButton.value,
                    color: GenColors.white,
                  ),
                ),
              ),
              _buildCardText,
            ],
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
                GenIcons.scancodeOutline,
                size: 112.0,
                color: GenColors.white.withOpacity(0.26),
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 0,
              child: Icon(
                GenIcons.barCode,
                size: 80.0,
                color: GenColors.white.withOpacity(0.26),
              ),
            ),
          ],
        );
      case LinkCardType.desk:
        return Stack(
          children: [
            Positioned(
              top: -20.0,
              left: -20.0,
              child: Icon(
                GenIcons.informationCircleOutline,
                size: 98.0,
                color: GenColors.white.withOpacity(0.26),
              ),
            ),
            Positioned(
              bottom: GenMeasures.base * 1.5,
              right: -64,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: GenColors.white.withOpacity(0.26),
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      GenColors.background.withOpacity(0.8),
                      GenColors.background.withOpacity(.05),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: const GradientRotation(math.pi - 10),
                    stops: const [.2, .7, .9],
                  ),
                ),
                child: SizedBox.fromSize(
                  size: const Size(
                    GenMeasures.base * 8.0,
                    GenMeasures.base * 8.0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -GenMeasures.base * 5,
              left: -GenMeasures.base * 3.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: GenColors.white.withOpacity(0.26),
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      GenColors.background,
                      GenColors.background.withOpacity(.05),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: const GradientRotation(math.pi - 4.2),
                    stops: const [.2, .7, .9],
                  ),
                ),
                child: SizedBox.fromSize(
                  size: const Size(
                    GenMeasures.base * 8.0,
                    GenMeasures.base * 8.0,
                  ),
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
                color: GenColors.white.withOpacity(0.26),
              ),
            ),
            Positioned(
              bottom: 36.0,
              left: -50,
              child: Icon(
                GenIcons.money,
                size: 64.0,
                color: GenColors.white.withOpacity(0.26),
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
                  color: GenColors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(
                    GenMeasures.borderRadius * 2.0,
                  ),
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
                GenIcons.carSide,
                size: 98.0,
                color: GenColors.white.withOpacity(.4),
              ),
            ),
          ],
        );
    }
  }
}
