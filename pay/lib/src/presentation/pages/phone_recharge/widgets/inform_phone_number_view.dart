import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/phone_entity.dart';
import '../../../../domain/enums/operator_type_enum.dart';

class InformPhoneNumberView extends StatefulWidget {
  const InformPhoneNumberView({super.key, required this.onInformPhone});

  final Function(String) onInformPhone;

  @override
  State<InformPhoneNumberView> createState() => _InformPhoneNumberViewState();
}

class _InformPhoneNumberViewState extends State<InformPhoneNumberView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: const Spacing(3).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Qual número você quer recarregar?',
                style: context.textTheme.titleMedium,
              ),
              Spacing.xs.vertical,
              Text(
                '''A recarga acontece em até 24 horas, este valor não pode ser reembolsado.''',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: context.textTheme.fontWeightLight,
                  color: AppColorsBase.neutrla5,
                ),
              ),
              Spacing.sm.vertical,
              CustomInputField(
                hintText: 'DDD + Número',
                inputFormatters: [FormMasks.phone()],
                validators: const [FormValidators.emptyField],
              ),
              Spacing.md.vertical,
              CustomButton.text(
                text: 'Continuar',
                onPressed: () => widget.onInformPhone(''),
              ),
              Spacing.md.vertical,
              Text(
                'Seus números',
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        Spacing.xxs.vertical,
        Expanded(child: _phoneList),
      ],
    );
  }

  Widget get _phoneList {
    return ValueListenableBuilder(
      valueListenable: ValueNotifier(
        true,
      ),
      builder: (context, value, child) {
        return ListView.separated(
          itemCount: 10,
          padding: EdgeInsets.all(const Spacing(2).value),
          separatorBuilder: (_, __) => Spacing.sm.vertical,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _phoneListItem(
                    PhoneEntity(
                      number: '(62) 99939-0024',
                      operator: OperatorType.vivo,
                    ),
                    isPrimary: true,
                  ),
                  Spacing.sm.vertical,
                  _phoneListItem(
                    PhoneEntity(
                      number: '(62) 99989-9749',
                      operator: OperatorType.claro,
                    ),
                  ),
                ],
              );
            }
            return _phoneListItem(
              PhoneEntity(
                number: '(62) 98204-1360',
                operator: OperatorType.oi,
              ),
              isSelected: (index + 1) % 2 != 0,
            );
          },
        );
      },
    );
  }

  Widget _phoneListItem(
    PhoneEntity phone, {
    bool isPrimary = false,
    bool isSelected = false,
  }) {
    return CustomCard(
      padding: EdgeInsets.all(const Spacing(1).value),
      border:
          isSelected ? Border.all(color: context.colorScheme.primary) : null,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: isPrimary
                  ? context.colorScheme.primary
                  : AppColorsBase.kContainerColor,
              borderRadius: context.theme.borderRadiusSM,
            ),
            child: Padding(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: SvgPicture.asset(
                'assets/images/payment/phone.svg',
                color: isPrimary ? null : AppColorsBase.neutrla5,
                height: const Spacing(3).value,
                width: const Spacing(3).value,
              ),
            ),
          ),
          Spacing.sm.horizontal,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  phone.number,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                    color: AppColorsBase.neutrla6,
                  ),
                ),
                Spacing.xxs.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        phone.operator.name,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColorsBase.neutrla4,
                          fontWeight: context.textTheme.fontWeightLight,
                        ),
                      ),
                    ),
                    if (isPrimary) ...[
                      Spacing.sm.horizontal,
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: context.theme.borderRadiusXSM,
                          color: AppColorsBase.kContainerColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(const Spacing(.5).value),
                          child: Text(
                            'Cadastrado',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: context.textTheme.fontWeightRegular,
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
