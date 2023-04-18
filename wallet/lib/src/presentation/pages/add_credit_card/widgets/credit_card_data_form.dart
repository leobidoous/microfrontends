import 'dart:async';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import '../../../../domain/entities/credit_card_entity.dart';
import '../../../../domain/enums/credit_card_type.dart';
import '../../../controllers/add_credit_card/add_credit_card_controller.dart';

class CreditCardDataForm extends StatefulWidget {
  final VoidCallback onContinue;
  final CreditCardEntity creditCard;

  const CreditCardDataForm({
    super.key,
    required this.onContinue,
    required this.creditCard,
  });

  @override
  State<CreditCardDataForm> createState() => _CreditCardDataFormState();
}

class _CreditCardDataFormState extends State<CreditCardDataForm> {
  final creditCardController = DM.i.get<AddCreditCardController>();
  final formKey = GlobalKey<FormState>();
  final cardNumberController = TextEditingController();
  final dateController = TextEditingController();
  final cvcController = TextEditingController();
  final nameController = TextEditingController();
  final cpfCnpjController = MaskedTextController(mask: '000.000.000-000');
  final cardNumberFocus = FocusNode();
  final dateFocus = FocusNode();
  final cvcFocus = FocusNode();
  final nameFocus = FocusNode();
  final cpfCnpjFocus = FocusNode();
  final streamButton = StreamController<bool>();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardNumberFocus.dispose();
    dateController.dispose();
    dateFocus.dispose();
    cvcController.dispose();
    cvcFocus.dispose();
    nameController.dispose();
    nameFocus.dispose();
    cpfCnpjController.dispose();
    cpfCnpjFocus.dispose();
    streamButton.close();
    super.dispose();
  }

  void validateForm() {
    streamButton.add((formKey.currentState?.validate() ?? false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollContent(
            padding: EdgeInsets.fromLTRB(
              const Spacing(2).value,
              const Spacing(2).value,
              const Spacing(2).value,
              Spacing.orKeyboardPadding(context, const Spacing(2).value),
            ),
            child: Column(
              children: [
                Text(
                  'Informe abaixo os dados do '
                  'cartão de \ncrédito e do titular do cartão',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleSmall,
                ),
                Spacing.lg.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: CreditCardType.values.map((e) {
                    return Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: e != CreditCardType.values.last ? 12 : 0,
                        ),
                        child: Image.asset(
                          e.image,
                          height: 32.responsiveHeight,
                          width: 64.responsiveWidth,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Spacing.lg.vertical,
                _creditCardForm,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder<bool>(
              stream: stream,
              initialData: false,
              builder: (context, snapshot) {
                return CustomButton.text(
                  isEnabled: snapshot.data!,
                  onPressed: widget.onContinue,
                  text: 'Continuar',
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget get _creditCardForm {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const InputLabel(label: 'Número do cartão de crédito*'),
          CustomInputField(
            hintText: '0000 0000 0000 0000',
            controller: cardNumberController,
            focusNode: cardNumberFocus,
            keyboardType: TextInputType.number,
            inputFormatters: [FormMasks.creditCard()],
            onChanged: (input) {
              if (input == null) return;
              widget.creditCard.cardNumber = input.replaceAll(' ', '');
              validateForm();
            },
            onFieldSubmitted: (input) {
              FocusScope.of(context).requestFocus(dateFocus);
            },
            validators: const [
              FormValidators.emptyField,
              FormValidators.invalidCreditCard,
            ],
            textInputAction: TextInputAction.next,
            suffixIcon: InkWell(
              onTap: () {
                CustomDialog.show(
                  context,
                  CustomAlert.paymentMethodWarning(context),
                  showClose: true,
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Icon(
                Icons.info_outline_rounded,
                color: AppColorsBase.grey7,
              ),
            ),
          ),
          Spacing.sm.vertical,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const InputLabel(label: 'Data de validade*'),
                    CustomInputField(
                      hintText: 'Mês/Ano',
                      keyboardType: TextInputType.number,
                      focusNode: dateFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (input) {
                        FocusScope.of(context).requestFocus(cvcFocus);
                      },
                      onChanged: (input) {
                        if (input == null) return;
                        final splited = input.split('/');
                        if (splited.length == 2) {
                          final month = splited.first;
                          final year = splited.last;
                          widget.creditCard.expirationYear = year;
                          widget.creditCard.expirationMonth = month;
                        }
                        validateForm();
                      },
                      inputFormatters: [
                        FormMasks.creditCardExpirationDate(),
                      ],
                      validators: const [
                        FormValidators.emptyField,
                        FormValidators.invalidCardExpirationDate,
                      ],
                    ),
                  ],
                ),
              ),
              Spacing.sm.horizontal,
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const InputLabel(label: 'CVC*'),
                    CustomInputField(
                      hintText: '0000',
                      keyboardType: TextInputType.number,
                      onChanged: (input) {
                        widget.creditCard.securityCode = input ?? '';
                        validateForm();
                      },
                      focusNode: cvcFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (input) {
                        FocusScope.of(context).requestFocus(nameFocus);
                      },
                      inputFormatters: [FormMasks.cvc()],
                      validators: [
                        FormValidators.emptyField,
                        (input) {
                          return FormValidators.invalidLength(input, 3);
                        }
                      ],
                      suffixIcon: InkWell(
                        onTap: () {
                          CustomDialog.show(
                            context,
                            CustomAlert.cvcInfo(context),
                            showClose: true,
                          );
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: AppColorsBase.grey7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacing.sm.vertical,
          const InputLabel(label: 'Nome do titular do cartão*'),
          CustomInputField(
            hintText: 'Informe o nome completo do titular',
            controller: nameController,
            focusNode: nameFocus,
            onFieldSubmitted: (input) {
              FocusScope.of(context).requestFocus(cpfCnpjFocus);
            },
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onChanged: (input) {
              if (input == null) return;
              widget.creditCard.holderName = input.trim();
              validateForm();
            },
            validators: const [
              FormValidators.emptyField,
              FormValidators.invalidFullName,
            ],
          ),
          Spacing.sm.vertical,
          const InputLabel(label: 'CPF / CNPJ do titular do cartão*'),
          CustomInputField(
            hintText: 'Informe o CPF ou CNPJ do titular',
            controller: cpfCnpjController,
            focusNode: cpfCnpjFocus,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onChanged: (input) {
              if (input == null) return;
              if (input.length < 15) {
                cpfCnpjController.updateMask('000.000.000-000');
              } else {
                cpfCnpjController.updateMask('00.000.000/0000-00');
              }
              widget.creditCard.cpfOrCnpj = input;
              validateForm();
            },
            validators: [
              (input) {
                if (input == null || input.isEmpty) {
                  return FormValidators.emptyField(input);
                }
                if (input.length < 15) {
                  return FormValidators.invalidCPF(input);
                } else {
                  return FormValidators.invalidCNPJ(input);
                }
              }
            ],
          ),
        ],
      ),
    );
  }

  Stream<bool> get stream => streamButton.stream;
}
