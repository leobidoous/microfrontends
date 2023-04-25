import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../controllers/warning_new_version_controller.dart';

class WarningNewVersionPageArgs {
  final bool forceUpdate;
  final Function() onContinue;

  WarningNewVersionPageArgs({
    required this.forceUpdate,
    required this.onContinue,
  });
}

class WarningNewVersionPage extends StatefulWidget {
  const WarningNewVersionPage({super.key, required this.args});

  final WarningNewVersionPageArgs args;

  @override
  State<WarningNewVersionPage> createState() => _WarningNewVersionPageState();
}

class _WarningNewVersionPageState extends State<WarningNewVersionPage> {
  final controller = DM.i.get<WarningNewVersionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/logos/gen_logotype_2.png',
              height: 58.0,
              width: 120.0,
            ),
            const SizedBox(height: 29.0),
            Text(
              '''Olá! Temos uma nova atualização para melhorar sua experiência!''',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64.0),
            CustomButton.text(
              text: 'Atualizar',
              onPressed: controller.goToStore,
            ),
            if (!widget.args.forceUpdate) ...[
              Spacing.sm.vertical,
              CustomButton.text(
                text: 'Continuar',
                type: ButtonType.background,
                onPressed: widget.args.onContinue,
              ),
            ],
            Spacing.xxl.vertical,
            Image.asset('assets/images/new_version.png'),
          ],
        ),
      ),
    );
  }
}
