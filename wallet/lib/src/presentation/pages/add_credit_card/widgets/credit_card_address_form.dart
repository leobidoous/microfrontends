import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/billing_address_entity.dart';
import '../../../controllers/add_credit_card/add_credit_card_address_controller.dart';

class CreditCardAddressForm extends StatefulWidget {
  final bool isLoading;
  final Function(BillingAddressEntity) onConfirm;

  const CreditCardAddressForm({
    super.key,
    required this.onConfirm,
    this.isLoading = false,
  });

  @override
  State<CreditCardAddressForm> createState() => _CreditCardAddressFormState();
}

class _CreditCardAddressFormState extends State<CreditCardAddressForm> {
  late final BillingAddressEntity address;
  final formKey = GlobalKey<FormState>();
  final controller = DM.i.get<AddCreditCardAddressController>();
  final postalCodeController = TextEditingController();
  final postalCodeFocus = FocusNode();
  final streetController = TextEditingController();
  final streetFocus = FocusNode();
  final numberController = TextEditingController();
  final numberFocus = FocusNode();
  final districtController = TextEditingController();
  final districtFocus = FocusNode();
  final complementController = TextEditingController();
  final complementFocus = FocusNode();
  final cityController = TextEditingController();
  final cityFocus = FocusNode();
  final ufController = TextEditingController();
  final ufFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    address = BillingAddressEntity(
      city: cityController.text,
      postalCode: postalCodeController.text,
      neighborhood: districtController.text,
      line1: streetController.text,
      line2: numberController.text,
      line3: complementController.text,
      state: ufController.text,
    );
  }

  void autocomplete(PostalCodeEntity address) {
    streetController.text = address.street;
    districtController.text = address.district;
    complementController.text = address.complement;
    cityController.text = address.city;
    ufController.text = address.ufCode;

    this.address.city = address.city;
    this.address.neighborhood = address.district;
    this.address.line1 = address.street;
    this.address.line3 = address.complement;
    this.address.state = address.ufCode;
  }

  void searchPostalCode() {
    controller.searchPostalCode(postalCodeController.text).then((value) {
      autocomplete(controller.state);
      FocusScope.of(context).requestFocus(streetFocus);
    });
  }

  void onConfirm() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    widget.onConfirm(address);
  }

  @override
  void dispose() {
    postalCodeController.dispose();
    streetController.dispose();
    numberController.dispose();
    districtController.dispose();
    complementController.dispose();
    cityController.dispose();
    ufController.dispose();
    postalCodeFocus.dispose();
    streetFocus.dispose();
    numberFocus.dispose();
    districtFocus.dispose();
    complementFocus.dispose();
    cityFocus.dispose();
    ufFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GenScrollContent(
            padding: EdgeInsets.fromLTRB(
              const Spacing(2).value,
              const Spacing(2).value,
              const Spacing(2).value,
              Spacing.orKeyboardPadding(context, const Spacing(2).value),
            ),
            child: Column(
              children: [
                Text(
                  'Informe abaixo o endereço de fatura \n'
                  'do cartão cadastrado',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleSmall,
                ),
                Spacing.lg.vertical,
                _addressForm,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GenButton.text(
              type: ButtonType.tertiary,
              isLoading: widget.isLoading,
              onPressed: onConfirm,
              text: 'Confirmar',
            ),
          ),
        ),
      ],
    );
  }

  Widget get _addressForm {
    return ValueListenableBuilder<PostalCodeEntity>(
      valueListenable: controller,
      builder: (context, state, child) {
        return Form(
          key: formKey,
          child: IgnorePointer(
            ignoring: widget.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const InputLabel(label: 'CEP*'),
                GenInputField(
                  controller: postalCodeController,
                  keyboardType: TextInputType.number,
                  focusNode: postalCodeFocus,
                  hintText: '000.000-00',
                  inputFormatters: [
                    FormMasks.zipCode(),
                  ],
                  suffixIcon: controller.isLoading
                      ? SizedBox(
                          width: AppThemeBase.inputHeightMD,
                          child: const GenLoading(),
                        )
                      : controller.hasError
                          ? InkWell(
                              onTap: searchPostalCode,
                              child: Icon(
                                Icons.refresh_rounded,
                                color: context.colorScheme.error,
                              ),
                            )
                          : null,
                  onChanged: (input) {
                    if (input == null) return;
                    if (input.length == 10) {
                      searchPostalCode();
                    }
                    address.postalCode = input.replaceAll(
                      RegExp(r'[^0-9]'),
                      '',
                    );
                  },
                  validators: const [FormValidators.emptyField],
                  onFieldSubmitted: (postalCode) {
                    searchPostalCode();
                  },
                  textInputAction: TextInputAction.next,
                ),
                Spacing.sm.vertical,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InputLabel(label: 'Rua*'),
                          GenInputField(
                            keyboardType: TextInputType.streetAddress,
                            hintText: 'Nome da rua',
                            onChanged: (input) {
                              if (input == null) return;
                              address.line1 = input;
                            },
                            controller: streetController,
                            focusNode: streetFocus,
                            onFieldSubmitted: (input) {
                              FocusScope.of(context).requestFocus(numberFocus);
                            },
                            validators: const [FormValidators.emptyField],
                            readOnly: state.street.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                    Spacing.sm.horizontal,
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InputLabel(label: 'Número*'),
                          GenInputField(
                            hintText: '0',
                            onChanged: (input) {
                              if (input == null) return;
                              address.line2 = input;
                            },
                            focusNode: numberFocus,
                            controller: numberController,
                            onFieldSubmitted: (input) {
                              FocusScope.of(context).requestFocus(
                                districtFocus,
                              );
                            },
                            validators: const [FormValidators.emptyField],
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacing.sm.vertical,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InputLabel(label: 'Bairro*'),
                          GenInputField(
                            hintText: 'Nome do bairro',
                            controller: districtController,
                            focusNode: districtFocus,
                            onChanged: (input) {
                              if (input == null) return;
                              address.neighborhood = input;
                            },
                            onFieldSubmitted: (input) {
                              FocusScope.of(context).requestFocus(
                                complementFocus,
                              );
                            },
                            validators: const [FormValidators.emptyField],
                            textInputAction: TextInputAction.next,
                            readOnly: state.district.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                    Spacing.sm.horizontal,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InputLabel(label: 'Complemento'),
                          GenInputField(
                            hintText: 'Ex.: Próximo à...',
                            controller: complementController,
                            onChanged: (input) {
                              if (input == null) return;
                              address.line3 = input;
                            },
                            onFieldSubmitted: (input) {
                              FocusScope.of(context).requestFocus(cityFocus);
                            },
                            focusNode: complementFocus,
                            textInputAction: TextInputAction.next,
                            readOnly: state.complement.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacing.sm.vertical,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InputLabel(label: 'Cidade*'),
                          GenInputField(
                            hintText: 'Nome da cidade',
                            validators: const [FormValidators.emptyField],
                            controller: cityController,
                            onFieldSubmitted: (input) {
                              FocusScope.of(context).requestFocus(ufFocus);
                            },
                            focusNode: cityFocus,
                            textInputAction: TextInputAction.next,
                            readOnly: state.city.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                    Spacing.sm.horizontal,
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const InputLabel(label: 'UF*'),
                          GenInputField(
                            hintText: 'UF',
                            focusNode: ufFocus,
                            controller: ufController,
                            onFieldSubmitted: (input) {
                              onConfirm();
                            },
                            validators: const [FormValidators.emptyField],
                            textInputAction: TextInputAction.done,
                            readOnly: state.ufCode.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
