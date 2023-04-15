import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../routes/ticket_window_routes.dart';


class TicketWindowPage extends StatefulWidget {
  const TicketWindowPage({super.key});

  @override
  State<TicketWindowPage> createState() => _TicketWindowPageState();
}

class _TicketWindowPageState extends State<TicketWindowPage> {
  final session = DM.i.get<SessionEntity>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar.zero(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GenScrollContent(
                  padding: EdgeInsets.only(top: const Spacing(5).value),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        context.tr.ticketWindowHelperText(
                          session.customer.name.capitalize,
                        ),
                        textStyle: context.textTheme.headlineMedium,
                        speed: const Duration(milliseconds: 25),
                      ),
                    ],
                  ),
                ),
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: () {
                  Nav.to.pushNamed(TicketWindowRoutes.takePhoto);
                },
                text: context.tr.takePicture,
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: Nav.to.pop,
                text: context.tr.close,
                type: ButtonType.background,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
