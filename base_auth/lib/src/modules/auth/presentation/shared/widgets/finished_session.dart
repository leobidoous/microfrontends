import 'package:base_style_sheet/base_style_sheet.dart'
    show DefaultCard, DefaultButton;
import 'package:core/core.dart' show CoreIcons, Modular;
import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        BuildContext,
        Theme,
        WillPopScope,
        Scaffold,
        Colors,
        Padding,
        EdgeInsets,
        Column,
        CrossAxisAlignment,
        MainAxisAlignment,
        Flexible,
        SingleChildScrollView,
        MainAxisSize,
        DecoratedBox,
        SizedBox,
        Text,
        BoxDecoration,
        TextAlign,
        Icon,
        BoxShape;

class FinishedSession extends StatelessWidget {
  const FinishedSession({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = Theme.of(context).textTheme;

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
                            color: _theme.colorScheme.error,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              CoreIcons.informationCircle,
                              color: _theme.backgroundColor,
                              size: 42,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sua sessão expirou.',
                          textAlign: TextAlign.center,
                          style: _textTheme.headline4,
                        ),
                        const SizedBox(height: 16),
                        DefaultButton(
                          onPressed: Modular.to.pop,
                          text: Text(
                            'Ir para o login',
                            style: _textTheme.bodyText2,
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
