import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'alerts/gen_alert.dart';
import 'buttons/gen_button.dart';
import 'gen_dialog.dart';

class RequestError extends StatelessWidget {
  final String message;
  final String btnLabel;
  final double? maxHeight;
  final EdgeInsets padding;
  final Function()? onPressed;
  final ButtonType btnType;

  const RequestError({
    Key? key,
    required this.message,
    this.onPressed,
    this.maxHeight,
    this.btnType = ButtonType.primary,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.btnLabel = 'Tentar novamente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        GenDialog.show(
                          context,
                          GenAlert(
                            asset: 'assets/images/server/server_error.svg',
                            title: 'Serviço temporariamente indisponível',
                            content: message,
                            btnConfirmLabel: context.tr.close,
                            onConfirm: Nav.to.pop,
                          ),
                          showClose: true,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/server/server_error.svg',
                        height: 100.responsiveHeight,
                      ),
                    ),
                    Spacing.md.vertical,
                    Text(
                      '''Serviço temporariamente indisponível. Tente novamente mais tarde.''',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Spacing.sm.vertical,
            if (onPressed != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: GenButton.text(
                  onPressed: onPressed,
                  text: btnLabel,
                  type: btnType,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
