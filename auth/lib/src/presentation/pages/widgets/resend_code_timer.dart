import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/timer_controller.dart';

class ResendCodeTimer extends StatefulWidget {
  const ResendCodeTimer({super.key, required this.onResendCode});

  final Function() onResendCode;

  @override
  State<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  final timerController = DM.i.get<TimerController>();

  @override
  void initState() {
    super.initState();
    timerController.startTimer();
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: timerController,
      builder: (context, value, child) {
        return Semantics(
          button: true,
          child: InkWell(
            onTap: !timerController.showTimer
                ? () {
                    timerController.startTimer();
                    widget.onResendCode();
                  }
                : null,
            child: Text(
              '''Não recebi o código ${timerController.showTimer ? '(${timerController.counter} seg)' : ''}''',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: context.textTheme.fontWeightMedium,
                color: !timerController.showTimer ? Colors.black : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
