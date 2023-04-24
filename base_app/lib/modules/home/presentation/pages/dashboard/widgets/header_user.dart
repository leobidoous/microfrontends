import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../app/presentation/controllers/session_controller.dart';
import '../../../../../notification/presentation/notification_routes.dart';
import '../../../controllers/dashboard_controller.dart';
import 'avatar_user.dart';
import 'hello_user.dart';

class HeaderUser extends StatelessWidget {
  final zenDeskController = DM.i.get<ZendeskController>();
  final sessionController = DM.i.get<SessionController>();
  final controller = DM.i.get<DashboardController>();

  HeaderUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarUser(name: sessionController.customer.name),
        Spacing.xs.horizontal,
        HelloUser(name: sessionController.customer.name),
        Row(
          children: [
            InkWell(
              onTap: () => zenDeskController.openChat(),
              child: Icon(
                CoreIcons.contactUs,
                size: AppFontSize.iconButton.value,
              ),
            ),
            Spacing.md.horizontal,
            InkWell(
              onTap: () => Nav.to.pushNamed(NotificationRoutes.root),
              child: Stack(
                children: [
                  Icon(
                    CoreIcons.bellAlt,
                    size: AppFontSize.iconButton.value,
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: context.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
