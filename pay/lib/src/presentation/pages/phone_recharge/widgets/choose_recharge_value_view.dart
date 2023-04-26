import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ChooseRechargeValueView extends StatelessWidget {
  const ChooseRechargeValueView({super.key, required this.onChooseValue});

  final Function(String) onChooseValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(const Spacing(3).value),
          child: Text(
            'Qual é o valor da recarga?',
            style: context.textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: ValueNotifier(false),
            builder: (context, state, child) {
              return CustomRefreshIndicator(
                onRefresh: () async {},
                child: ListView.separated(
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(
                    horizontal: const Spacing(3).value,
                  ),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  separatorBuilder: (_, __) => Divider(
                    height: const Spacing(4).value,
                    color: AppColorsBase.neutrla1,
                  ),
                  itemBuilder: (_, index) {
                    return CustomRadioTile(
                      isSelected: (index + 1) % 2 == 0,
                      value: index,
                      onChanged: (value) {},
                      title: Text(
                        NumberFormat.toCurrency(index),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColorsBase.neutrla7,
                          fontSize: AppFontSize.bodyLarge.value,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(const Spacing(2).value),
          child: CustomButton.text(
            text: 'Continuar',
            onPressed: () => onChooseValue(''),
          ),
        ),
      ],
    );
  }
}
