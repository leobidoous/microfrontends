import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../core/themes/app_colors_base.dart';
import '../../../../../../core/themes/app_theme_factory.dart';
import '../../../../../../core/themes/spacing/spacing.dart';
import '../../../../../../core/utils/dependency_manager.dart';
import '../../../../../../core/utils/validators/form_validator.dart';
import '../../../../../../shared/presentation/widgets/buttons/gen_button.dart';
import '../../../../../../shared/presentation/widgets/gen_scroll_content.dart';
import '../../../controllers/login/login_controller.dart';
import 'form_header.dart';

class PinCodeFormView extends StatefulWidget {
  const PinCodeFormView({
    super.key,
    required this.onConfirm,
    required this.onRequestCode,
    required this.textController,
  });

  final Function(String phone, String code) onConfirm;
  final Function(String phone) onRequestCode;
  final TextEditingController textController;

  @override
  State<PinCodeFormView> createState() => _PinCodeFormViewState();
}

class _PinCodeFormViewState extends State<PinCodeFormView> {
  final controller = DM.i.get<LoginController>();
  final FocusNode pinFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  late final String phoneNumber;

  TextStyle? get pinTextStyle => context.textTheme.bodyLarge?.copyWith(
        fontWeight: context.textTheme.fontWeightMedium,
        color: const Color(0xFF4E4B59),
      );

  PinTheme get defaultTheme => PinTheme(
        width: const Spacing(7).value,
        height: const Spacing(7).value,
        textStyle: pinTextStyle,
        decoration: BoxDecoration(
          borderRadius: context.theme.borderRadiusXSM,
          border: Border.all(color: const Color(0xFFE7E7EF)),
          color: AppColorsBase.kScaffoldBackgroundColorSecondary,
        ),
      );

  PinTheme get focusedTheme => PinTheme(
        width: const Spacing(7).value,
        height: const Spacing(7).value,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: context.colorScheme.primary),
          borderRadius: context.theme.borderRadiusXSM,
        ),
      );

  PinTheme get errorTheme => PinTheme(
        width: const Spacing(7).value,
        height: const Spacing(7).value,
        textStyle: pinTextStyle,
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.error),
          borderRadius: context.theme.borderRadiusXSM,
        ),
      );

  @override
  void initState() {
    phoneNumber = controller.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    pinFocus.dispose();
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '''Insira o código de 6 dígitos que enviamos para o número +55 $phoneNumber.''',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: context.textTheme.fontWeightLight,
                ),
              ),
            ),
            Spacing.lg.vertical,
            Pinput(
              length: 6,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              focusNode: pinFocus,
              controller: widget.textController,
              defaultPinTheme: defaultTheme,
              focusedPinTheme: focusedTheme,
              errorPinTheme: errorTheme,
              pinAnimationType: PinAnimationType.fade,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onChanged: (_) => controller.validateCode(_),
              validator: (input) {
                String? error;
                [FormValidators.emptyField].forEach((val) {
                  if (error == null) {
                    error = val(input);
                    return;
                  }
                });
                return error;
              },
              onCompleted: (value) {
                widget.onConfirm(phoneNumber, value);
              },
              closeKeyboardWhenCompleted: true,
              keyboardType: TextInputType.number,
            ),
            Spacing.lg.vertical,
            Semantics(
              button: true,
              child: ValueListenableBuilder(
                valueListenable: controller.timerController,
                builder: (context, value, child) {
                  return InkWell(
                    onTap: !controller.timerController.showTimer
                        ? controller.onResendCode
                        : null,
                    child: Text(
                      '''Não recebi o código ${controller.timerController.showTimer ? '(${controller.timerController.counter} seg)' : ''}''',
                      textScaleFactor: 1.0,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: context.textTheme.fontWeightMedium,
                        color: !controller.timerController.showTimer
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacing.md.vertical,
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return GenButton.text(
                  text: 'Confirmar',
                  isEnabled: controller.codeIsValid,
                  isLoading: controller.isLoading,
                  onPressed: () => widget.onConfirm(
                    phoneNumber,
                    widget.textController.text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
