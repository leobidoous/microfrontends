import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BoxShape,
        BuildContext,
        Colors,
        Column,
        CrossAxisAlignment,
        DecoratedBox,
        EdgeInsets,
        Flexible,
        Icon,
        Icons,
        MainAxisAlignment,
        MainAxisSize,
        Padding,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        StatelessWidget,
        Text,
        TextAlign,
        Widget,
        WillPopScope;

import '../widgets/button.dart';
import '../widgets/default_card.dart';

class ConfirmExitView extends StatelessWidget {
  const ConfirmExitView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: DefaultCard(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.error,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: context.colorScheme.background,
                              size: 42,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sua sessão expirou.',
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 16),
                        Button(
                          onPressed: Nav.to.pop,
                          child: Text(
                            'Ir para o login',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
