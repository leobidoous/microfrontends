import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/recent_researches_entity.dart';

class RecentResearchesItem extends StatelessWidget {
  final RecentResearchesEntity recent;
  final Function(RecentResearchesEntity) onRemove;
  final Function(RecentResearchesEntity) onTapItem;
  const RecentResearchesItem({
    super.key,
    required this.recent,
    required this.onRemove,
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
                    recent.term.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    FormatDate.toDateTime(recent.createdAt),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => onRemove(recent),
              child: Icon(
                Icons.close_rounded,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
