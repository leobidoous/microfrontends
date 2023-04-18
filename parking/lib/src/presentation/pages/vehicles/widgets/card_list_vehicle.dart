import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CardVehicle extends StatelessWidget {
  const CardVehicle({
    Key? key,
    required this.brand,
    required this.model,
    required this.plate,
    required this.onPressed,
  }) : super(key: key);

  final String brand;
  final String model;
  final String plate;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColorsBase.kWhite,
        borderRadius: AppThemeBase.borderRadiusSM,
        border: Border.all(
          color: AppColorsBase.grey3,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: const Spacing(4).value,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: const Spacing(3).value,
              ),
              child: Icon(
                GenIcons.carSide,
                size: 26,
                color: AppColorsBase.greyText01,
              ),
            ),
            SizedBox(
              height: 40,
              child: VerticalDivider(
                width: 1,
                thickness: 2,
                color: AppColorsBase.grey2,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: const Spacing(2).value,
                  horizontal: const Spacing(3).value,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        brand,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: AppColorsBase.primary10Color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: const Spacing(1).value,
                      ),
                      child: Text(
                        model,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColorsBase.greyText02,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Text(
                      'Placa $plate',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColorsBase.greyText02,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onPressed,
              highlightColor: Colors.red.withOpacity(.16),
              icon: Icon(
                GenIcons.deleteOutline,
                size: 24,
                color: AppColorsBase.error0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
