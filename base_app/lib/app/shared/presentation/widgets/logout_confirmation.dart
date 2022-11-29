import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:flutter/material.dart';

class LogoutConfirmation extends StatelessWidget {
  const LogoutConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Encerrar sessão',
            style: Theme.of(context).textTheme.headline3,
          ),
          Divider(
            height: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Text(
            'Você tem certeza que deseja encerrar sua sessão?',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  type: ButtonType.background,
                  text: Text(
                    'Cancelar',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DefaultButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  text: Text(
                    'Sair',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
