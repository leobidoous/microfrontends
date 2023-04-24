import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/notification_entity.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  final NotificationEntity notification;
  final Function(NotificationEntity) onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () => onTap(notification),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (!notification.read) ...[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      height: context.textTheme.bodyMedium?.fontSize,
                      width: context.textTheme.bodyMedium?.fontSize,
                    ),
                  ),
                  Spacing.xs.horizontal,
                ],
                Expanded(
                  child: Text(
                    notification.title,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: notification.read
                          ? null
                          : context.colorScheme.primary,
                      fontWeight: notification.read
                          ? context.textTheme.fontWeightLight
                          : context.textTheme.fontWeightBold,
                    ),
                  ),
                ),
                Text(
                  DateFormat.toDateTime(
                    notification.date,
                    pattern: 'dd/MM/yyyy HH:mm',
                  ),
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: notification.read
                        ? context.textTheme.fontWeightLight
                        : context.textTheme.fontWeightBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              notification.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: context.textTheme.labelMedium?.copyWith(
                fontWeight: notification.read
                    ? context.textTheme.fontWeightLight
                    : context.textTheme.fontWeightBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
