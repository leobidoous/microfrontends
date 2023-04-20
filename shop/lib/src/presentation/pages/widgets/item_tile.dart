import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final String title;
  final String brand;

  const ItemTile({
    super.key,
    required this.title,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      radius: BorderRadius.circular(const Spacing(1).value),
      child: Padding(
        padding: EdgeInsets.all(const Spacing(1).value),
        child: Row(
          children: [
            brand != ''
                ? Container(
                    margin: EdgeInsets.only(right: const Spacing(1).value),
                    width: 48,
                    height: 48,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(const Spacing(0.5).value),
                      child: Image.network(
                        brand,
                        height: 150.0,
                        width: 100.0,
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(right: const Spacing(1).value),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000000),
                      borderRadius:
                          BorderRadius.circular(const Spacing(0.5).value),
                    ),
                  ),
            Flexible(
              child: Text(
                title,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: AppFontWeight.regular.value,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
