import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/notification_entity.dart';
import '../notification_controller.dart';
import 'widgets/notification_list_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final controller = DM.i.get<NotificationController>();
  @override
  void initState() {
    super.initState();
    controller.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notificações'),
      body: SafeArea(
        child: CustomScrollContent(
          onRefresh: () async {
            controller.fetchNotifications();
          },
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              if (controller.isLoading) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: 20,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) => _notificationListItemShimmer,
                );
              } else if (controller.hasError) {
                return RequestError(
                  message: controller.error.toString(),
                  padding: EdgeInsets.symmetric(
                    horizontal: const Spacing(3).value,
                    vertical: const Spacing(2).value,
                  ),
                );
              } else if (state.isEmpty) {
                return ListEmpty(
                  padding: EdgeInsets.all(const Spacing(2).value),
                  asset: 'assets/images/wallet/transactions.svg',
                  message: 'Você ainda não possui notificações',
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.length,
                separatorBuilder: (_, __) => Divider(
                  height: const Spacing(4).value,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: const Spacing(3).value,
                    ),
                    child: NotificationListItem(
                      notification: state[index],
                      onTap: (notification) {
                        controller.markAsRead(notification);
                        CustomDialog.show(
                          context,
                          _notificationDialog(notification),
                          showClose: true,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _notificationListItemShimmer {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: const Spacing(3).value,
        vertical: const Spacing(2).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CustomShimmer(
                height: const Spacing(1.5).value,
                width: const Spacing(2).value,
              ),
              Spacing.sm.horizontal,
              Expanded(child: CustomShimmer(height: const Spacing(1.5).value)),
              Spacing.sm.horizontal,
              CustomShimmer(
                height: const Spacing(1.5).value,
                width: const Spacing(10).value,
              ),
            ],
          ),
          Spacing.sm.vertical,
          CustomShimmer(height: const Spacing(1.5).value),
          Spacing.xxs.vertical,
          CustomShimmer(height: const Spacing(1.5).value),
          Spacing.xxs.vertical,
          CustomShimmer(height: const Spacing(1.5).value),
        ],
      ),
    );
  }

  Widget _notificationDialog(NotificationEntity notification) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          notification.title,
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        Spacing.md.vertical,
        Text(
          notification.description,
          style: context.textTheme.bodyMedium,
        ),
        Spacing.md.vertical,
        Text(
          DateFormat.toDate(
            notification.date,
            pattern: 'dd/MM/yyyy HH:mm',
          ),
          style: context.textTheme.labelSmall,
        ),
        Spacing.md.vertical,
        CustomButton.text(
          text: 'Fechar',
          onPressed: Nav.to.pop,
        ),
      ],
    );
  }
}
