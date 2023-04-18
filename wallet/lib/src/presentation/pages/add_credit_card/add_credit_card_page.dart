import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/add_credit_card/add_credit_card_controller.dart';
import 'widgets/credit_card_address_form.dart';
import 'widgets/credit_card_data_form.dart';

class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({super.key});

  @override
  State<AddCreditCardPage> createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  final creditCardController = DM.i.get<AddCreditCardController>();
  final pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void registerCreditCard(address) {
    FocusScope.of(context).requestFocus(FocusNode());
    creditCardController.createCreditCard(address).then((value) async {
      if (creditCardController.hasError) {
        GenDialog.show(
          context,
          GenAlert.paymentError(context),
          showClose: true,
        ).then((value) {
          pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        });
        return;
      }
      Nav.to.pop(
        context: context,
        response: creditCardController.state,
      );
      await GenDialog.show(
        context,
        GenAlert.cardRegisterSuccess(context),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: 'Cadastro de Cartão',
        actions: [
          AppBarButton(
            child: Icon(
              CoreIcons.contactUs,
              color: context.colorScheme.onBackground,
            ),
            onTap: () => DM.i.get<ZendeskController>().openChat(),
          ),
        ],
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CreditCardDataForm(
                  key: const ValueKey(1),
                  creditCard: creditCardController.state,
                  onContinue: () {
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: creditCardController,
                  builder: (_, state, child) {
                    return CreditCardAddressForm(
                      key: const ValueKey(2),
                      onConfirm: registerCreditCard,
                      isLoading: creditCardController.isLoading,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
