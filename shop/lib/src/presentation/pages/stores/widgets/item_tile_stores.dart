import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/store_address_entity.dart';

class ItemTileStores extends StatelessWidget {
  final String title;
  final String day;
  final List<dynamic> openingHours;
  final StoreAddressEntity address;

  const ItemTileStores({
    super.key,
    required this.title,
    required this.day,
    required this.openingHours,
    required this.address,
  });

  String get openingHoursFormatted {
    String open = '';
    String close = '';
    for (int i = 0; i < openingHours.length; i++) {
      if (openingHours[i]['weekDay'] == day) {
        open = openingHours[i]['open'];
        close = openingHours[i]['close'];
      }
    }
    return '$open às $close';
  }

  String get addressFormatted => '${address.line1}, '
      'N° ${address.line2}\n'
      '${address.neighborhood} - '
      '${address.city} - '
      '${address.state}\n'
      '${address.line3}';

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: BorderRadius.circular(const Spacing(1).value),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: const Spacing(3).value,
          vertical: const Spacing(2).value,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: context.textTheme.titleMedium!.copyWith(
                          fontFamily: 'Poppins',
                          color: AppColorsBase.neutrla7,
                          fontWeight: AppFontWeight.medium.value,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      CoreIcons.chevronRight,
                      size: 24,
                      color: AppColorsBase.primary,
                    ),
                  ],
                ),
                SizedBox(height: const Spacing(1).value),
                Text(
                  openingHoursFormatted,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontFamily: 'Poppins',
                    color: AppColorsBase.neutrla7,
                    fontWeight: AppFontWeight.light.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: const Spacing(3).value),
            Text(
              addressFormatted,
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: 'Poppins',
                color: AppColorsBase.neutrla7,
                fontWeight: AppFontWeight.light.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
