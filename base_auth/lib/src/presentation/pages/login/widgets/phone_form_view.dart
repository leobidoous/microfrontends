import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../controllers/login/login_controller.dart';
import 'form_header.dart';

class PhoneFormView extends StatefulWidget {
  const PhoneFormView({
    super.key,
    required this.onConfirm,
    required this.textController,
  });

  final Function(String phone) onConfirm;
  final TextEditingController textController;

  @override
  State<PhoneFormView> createState() => _PhoneFormViewState();
}

class _PhoneFormViewState extends State<PhoneFormView> {
  final controller = DM.i.get<LoginController>();
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.validatePhone(textController.text);
    });
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
      child: GenScrollContent(
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
            GenInputField(
              controller: textController,
              hintText: 'Ex: (00) 00000-0000',
              onFieldSubmitted: (_) => widget.onConfirm(_),
              onChanged: (_) => controller.validatePhone(_ ?? ''),
              validators: const [FormValidators.emptyField],
              inputFormatters: [FormMasks.phone()],
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
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return GenButton.text(
                  text: 'Receber código por SMS',
                  isEnabled: controller.phoneIsValid,
                  isLoading: controller.isLoading,
                  onPressed: () => widget.onConfirm(textController.text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
