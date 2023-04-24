import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../widgets/form_header.dart';

class RegisterCpfView extends StatefulWidget {
  const RegisterCpfView({super.key, required this.onConfirm});

  final Future Function(String) onConfirm;

  @override
  State<RegisterCpfView> createState() => _RegisterCpfViewState();
}

class _RegisterCpfViewState extends State<RegisterCpfView> {
  final cpfField = const ValueKey('cpf_field');
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool cpfIsValid = false;
  bool isLoading = false;

  bool validateCpf(String? input) {
    setState(() {
      cpfIsValid = FormValidators.invalidCPF(input) == null &&
          FormValidators.emptyField(input) == null;
    });
    return cpfIsValid;
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

  List<TextInputFormatter> get inputFormatters => [FormMasks.cpf()];

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(text: 'Agora, informe seu CPF'),
          Spacing.sm.vertical,
          Text(
            '''Para confirmar sua identidade e garantir segurança nas transações.''',
            style: context.textTheme.bodyMedium,
          ),
          Spacing.sm.vertical,
          Form(
            key: formKey,
            child: CustomInputField(
              key: cpfField,
              controller: textController,
              hintText: 'Ex: 000.000.000-00',
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) => onConfirm(),
              validators: const [
                FormValidators.emptyField,
                FormValidators.invalidCPF,
              ],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FormMasks.cpf(),
              ],
              onChanged: validateCpf,
              labelWidget: const InputLabel(label: 'Digite seu CPF'),
            ),
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Avançar',
            isEnabled: cpfIsValid,
            isLoading: isLoading,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
