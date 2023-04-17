import 'package:auth/src/presentation/pages/register/widgets/register_terms_view.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/register/register_controller.dart';
import 'widgets/register_address_view.dart.dart';
import 'widgets/register_cpf_view.dart.dart';
import 'widgets/register_email_view.dart';
import 'widgets/register_full_name_view.dart.dart';
import 'widgets/register_phone_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    required this.redirectTo,
    required this.onLoginCallback,
  }) : super(key: key);

  final BasePath redirectTo;
  final Future Function(SessionEntity) onLoginCallback;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = DM.i.get<RegisterController>();
  final scrollController = ScrollController();
  final pageController = PageController();
  bool showFloatingButton = true;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final max = scrollController.position.maxScrollExtent;
      if (scrollController.offset >= max) {
        if (showFloatingButton) setState(() => showFloatingButton = false);
      } else {
        if (!showFloatingButton) setState(() => showFloatingButton = true);
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: pageIndex == 5 ? 'Termos e Condições' : 'Cadastro',
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) {
            setState(() => pageIndex = index);
          },
          controller: pageController,
          children: [
            const RegisterFullNameView(),
            const RegisterCpfView(),
            const RegisterPhoneView(),
            const RegisterEmailView(),
            RegisterAddressView(
              onConfirm: (address) {},
            ),
            RegisterTermsView(scrollController: scrollController),
          ],
        ),
      ),
      floatingActionButton: showFloatingButton && pageIndex == 5
          ? FloatingActionButton(
              mini: true,
              backgroundColor: context.colorScheme.primary,
              onPressed: () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate,
                );
              },
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.colorScheme.background,
              ),
            )
          : null,
    );
  }
}
