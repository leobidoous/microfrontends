import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/stocks_entity.dart';


class StocksListItem extends StatelessWidget {
  final StocksEntity recent;
  final Function(StocksEntity) onTapItem;
  const StocksListItem({
    super.key,
    required this.recent,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onTapItem(recent),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    recent.symbol.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
