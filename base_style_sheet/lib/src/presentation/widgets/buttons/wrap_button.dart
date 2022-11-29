import 'package:flutter/material.dart';

import 'default_button.dart';

class WrapButton extends StatelessWidget {
  const WrapButton({
    Key? key,
    required this.label,
    required this.coreIcon,
    required this.onTap,
    this.type = ButtonType.secondary,
  }) : super(key: key);

  final String label;
  final ButtonType type;
  final IconData coreIcon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultButton(
          text: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Icon(
              coreIcon,
              size: 32,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          type: type,
          onPressed: onTap,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }
}
