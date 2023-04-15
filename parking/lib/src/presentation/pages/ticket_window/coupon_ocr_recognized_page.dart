import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../routes/ticket_window_routes.dart';
import 'widgets/photo_list_item.dart';

class CouponOcrRecognizedPage extends StatefulWidget {
  const CouponOcrRecognizedPage({super.key, required this.files});

  final List<File> files;

  @override
  State<CouponOcrRecognizedPage> createState() =>
      _CouponOcrRecognizedPageState();
}

class _CouponOcrRecognizedPageState extends State<CouponOcrRecognizedPage> {
  Future<void> _showWarning() async {
    await GenDialog.show(
      context,
      GenAlert.validateAfterConfirm(
        context,
        btnCancelLabel: 'Cancelar',
        btnConfirmLabel: 'Sair',
        onConfirm: () => Nav.to.pop(response: true),
      ),
      showClose: true,
    ).then((value) {
      if (value == true) {
        Nav.to.popUntil(
          ModalRoute.withName(TicketWindowRoutes.root.completePath),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar.zero(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            const Spacing(2).value,
            const Spacing(5).value,
            const Spacing(2).value,
            const Spacing(2).value,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Identifiquei ',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightLight,
                  ),
                  children: [
                    TextSpan(
                      text: widget.files.length != 1
                          ? '${widget.files.length} cupons '
                          : '${widget.files.length} cupom ',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: context.textTheme.fontWeightMedium,
                      ),
                    ),
                    const TextSpan(text: 'no valor total de: '),
                    TextSpan(
                      text: NumberFormat.toCurrency(300),
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: context.textTheme.fontWeightMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Spacing.xs.vertical,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(top: const Spacing(5).value),
                  itemCount: widget.files.length,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  separatorBuilder: (_, __) => Spacing.sm.vertical,
                  itemBuilder: (_, index) => PhotoListItem(
                    file: widget.files[index],
                  ),
                ),
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: () {
                  Nav.to.pushNamed(TicketWindowRoutes.couponSubmissionResult);
                },
                type: ButtonType.tertiary,
                text: 'Confirmar valor',
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: () {
                  Nav.to.popUntil(
                    ModalRoute.withName(
                      TicketWindowRoutes.takePhoto.completePath,
                    ),
                  );
                },
                text: 'Enviar mais cupons',
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: _showWarning,
                text: 'Validar depois',
                type: ButtonType.background,
              ),
              Spacing.sm.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
