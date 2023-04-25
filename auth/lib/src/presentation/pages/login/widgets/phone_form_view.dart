import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/form_header.dart';

class PhoneFormView extends StatefulWidget {
  const PhoneFormView({super.key, required this.onConfirm});

  final Function(String phone) onConfirm;

  @override
  State<PhoneFormView> createState() => _PhoneFormViewState();
}

class _PhoneFormViewState extends State<PhoneFormView> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool phoneIsValid = false;
  bool isLoading = false;

  bool validatePhone(String? input) {
    setState(() {
      phoneIsValid = FormValidators.emptyField(input) == null;
    });
    return phoneIsValid;
  }

  Future<void> onConfirm() async {
    if (!(formKey.currentState?.validate() ?? true)) return;
    setState(() => isLoading = true);
    await widget.onConfirm(textController.text);
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CustomScrollContent(
        padding: EdgeInsets.all(const Spacing(2).value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FormHeader(),
            Text(
              '''Digite o número do seu celular. Seus dados estão seguros e você não precisa de senha.''',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightLight,
              ),
            ),
            Spacing.xxl.vertical,
            Text(
              'Celular',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: context.textTheme.fontWeightLight,
              ),
            ),
            CustomInputField(
              controller: textController,
              hintText: 'Ex: (00) 00000-0000',
              onFieldSubmitted: (_) => widget.onConfirm(_),
              onChanged: validatePhone,
              validators: const [FormValidators.emptyField],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FormMasks.phone(),
              ],
              keyboardType: TextInputType.number,
            ),
            Spacing.xs.vertical,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '''Você vai receber um código por SMS para confirmar seu telefone.''',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: context.textTheme.fontWeightLight,
                ),
              ),
            ),
            Spacing.xxl.vertical,
            CustomButton.text(
              text: 'Receber código por SMS',
              isEnabled: phoneIsValid,
              isLoading: isLoading,
              onPressed: onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
