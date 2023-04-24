import 'package:auth/auth.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import '../../../app/presentation/controllers/session_controller.dart';
import '../../../home/presentation/routes/home_routes.dart';
import '../../domain/entities/profile_menu_item_entity.dart';
import '../../domain/enums/menu_item_type_enum.dart';
import '../profile_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final sessionController = DM.i.get<SessionController>();

  List<ProfileMenuItemEntity> get menuItems => [
        ProfileMenuItemEntity(
          name: 'Meus dados',
          assetIcon: '',
          onTap: () {
            Nav.to.pushNamed(ProfileRoutes.profileDetails);
          },
        ),
        ProfileMenuItemEntity(
          name: 'Carteira',
          assetIcon: '',
          onTap: () {
            Nav.to.pushNamed(
              HomeRoutes.start.concate(WalletRoutes.root),
              forRoot: true,
            );
          },
        ),
        ProfileMenuItemEntity(name: 'Notificações', assetIcon: ''),
        ProfileMenuItemEntity(name: 'Minha localização', assetIcon: ''),
        ProfileMenuItemEntity(
          name: 'Informações',
          assetIcon: '',
          type: MenuItemType.expandable,
        ),
        ProfileMenuItemEntity(
          name: 'Ajuda',
          assetIcon: '',
          type: MenuItemType.expandable,
        ),
        ProfileMenuItemEntity(
          name: 'Sair da conta',
          assetIcon: '',
          onTap: () async {
            CustomDialog.show(
              context,
              CustomAlert(
                asset: 'assets/images/server/warning.svg',
                title: 'Você tem certeza que deseja sair da conta?',
                btnConfirmLabel: 'Sair',
                content:
                    '''Você será redirecionado para tela de login e poderá entrar novamente quando quiser.''',
                onConfirm: () {
                  Nav.to.pop();
                  sessionController.logout();
                },
                btnCancelLabel: 'Cancelar',
                onCancel: Nav.to.pop,
              ),
              showClose: true,
            );
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Configurações'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollContent(
                padding: EdgeInsets.all(const Spacing(3).value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _avatarHeader,
                    Spacing.md.vertical,
                    if (sessionController.hasEmailVerified) ...[
                      _validateEmailWarning,
                      Spacing.md.vertical,
                    ],
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: menuItems.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (_, index) {
                        switch (menuItems[index].type) {
                          case MenuItemType.expandable:
                            return CustomExpansion(
                              value: menuItems[index],
                              body: const SizedBox(),
                              showDivider: false,
                              padding: EdgeInsets.all(const Spacing(1).value),
                              title: _menuListItem(menuItems[index]),
                            );
                          case MenuItemType.clickable:
                            return Semantics(
                              button: true,
                              child: InkWell(
                                onTap: menuItems[index].onTap,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    const Spacing(1).value,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _menuListItem(
                                          menuItems[index],
                                          errorTheme:
                                              index == menuItems.length - 1,
                                        ),
                                      ),
                                      Spacing.sm.horizontal,
                                      Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: AppColorsBase.neutrla5,
                                        size: const Spacing(3).value,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _validateEmailWarning {
    return CustomCard(
      radius: context.theme.borderRadiusSM,
      padding: EdgeInsets.symmetric(
        vertical: const Spacing(1.5).value,
        horizontal: const Spacing(2).value,
      ),
      onTap: () {
        Nav.to.pushNamed(
          RegisterRoutes.validateEmail,
          forRoot: true,
          arguments: (CustomerEntity customer) async {
            sessionController.updateSession(customer: customer);
          },
        );
      },
      color: AppColorsBase.neutrla2,
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: const Spacing(3.5).value,
            color: AppColorsBase.kSecondaryColor,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Valide seu e-mail',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColorsBase.neutrla6,
                  ),
                ),
                Spacing.xxs.vertical,
                Text(
                  'Para realizar pagamentos pelo app',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColorsBase.neutrla5,
                  ),
                ),
              ],
            ),
          ),
          Spacing.sm.horizontal,
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppColorsBase.neutrla5,
            size: const Spacing(3).value,
          )
        ],
      ),
    );
  }

  Widget _menuListItem(
    ProfileMenuItemEntity item, {
    bool errorTheme = false,
  }) {
    return Row(
      children: [
        Icon(
          Icons.arrow_right_rounded,
          color:
              errorTheme ? context.colorScheme.error : AppColorsBase.neutrla5,
        ),
        Spacing.sm.horizontal,
        Expanded(
          child: Text(
            item.name,
            style: context.textTheme.bodyMedium?.copyWith(
              color: errorTheme
                  ? context.colorScheme.error
                  : AppColorsBase.neutrla5,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _avatarHeader {
    final breakName = sessionController.state.customer.name.trim().split(' ');
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorsBase.neutrla3,
          ),
          child: Padding(
            padding: EdgeInsets.all(const Spacing(2).value),
            child: Text(
              '${breakName.first.substring(0, 1).toUpperCase()}'
              '${breakName.last.substring(0, 1).toUpperCase()}',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.background,
                fontSize: AppFontSize.displayMedium.value,
              ),
            ),
          ),
        ),
        Text(
          sessionController.state.customer.name.capitalize,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: context.textTheme.fontWeightMedium,
          ),
        ),
        Spacing.xs.vertical,
        Text(
          sessionController.state.customer.phone,
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColorsBase.neutrla5,
          ),
        ),
        Text(
          sessionController.state.customer.email,
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColorsBase.neutrla5,
          ),
        ),
      ],
    );
  }
}
