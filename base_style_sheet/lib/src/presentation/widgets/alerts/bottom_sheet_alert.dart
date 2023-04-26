import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../buttons/custom_button.dart';
import '../custom_scroll_content.dart';

class BottomSheetAlert extends StatelessWidget {
  const BottomSheetAlert({
    super.key,
    required this.title,
    this.asset,
    this.content,
    this.isContentBold = false,
    this.subtitle,
    this.btnCancelLabel = '',
    required this.btnConfirmLabel,
    required this.onConfirm,
    this.onCancel,
  });
  final String? asset;
  final String title;
  final String? subtitle;
  final String? content;
  final bool? isContentBold;
  final String btnConfirmLabel;
  final String btnCancelLabel;
  final Function() onConfirm;
  final Function()? onCancel;

  factory BottomSheetAlert.emailVerified(BuildContext context) =>
      BottomSheetAlert(
        title: 'Valide seu e-mail',
        content:
            '''Informe e verifique seu e-mail para concluir o pagamento da recarga.''',
        btnConfirmLabel: 'Validar e-mail',
        onConfirm: Nav.to.pop,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (asset != null) ...[
          SvgPicture.asset(
            asset!,
            height: 100.responsiveHeight,
          ),
          Spacing.md.vertical,
        ],
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        if (subtitle != null) ...[
          Spacing.md.vertical,
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
        ],
        if (content != null) ...[
          Spacing.md.vertical,
          Flexible(
            child: CustomScrollContent(
              expanded: false,
              child: SelectableText(
                content!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: isContentBold! ? FontWeight.w600 : null,
                ),
              ),
            ),
          )
        ],
        Spacing.md.vertical,
        Row(
          children: [
            if (onCancel != null) ...[
              Expanded(
                child: CustomButton.text(
                  onPressed: onCancel,
                  text: btnCancelLabel,
                  type: ButtonType.background,
                ),
              ),
              Spacing.sm.horizontal,
            ],
            Expanded(
              child: CustomButton.text(
                onPressed: onConfirm,
                text: btnConfirmLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
