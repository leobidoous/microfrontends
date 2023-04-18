import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AvatarUser extends StatelessWidget {
  const AvatarUser({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final breakName = name.trim().split(' ');

    return SizedBox(
      child: CircleAvatar(
        radius: const Spacing(3).value,
        backgroundColor: const Color(0xFFD1C5FC),
        child: Text(
          '${breakName.first.substring(0, 1).toUpperCase()}'
          '${breakName.last.substring(0, 1).toUpperCase()}',
          style: context.textTheme.bodyMedium!.copyWith(
            fontFamily: context.textTheme.secodaryFontFamily,
            fontSize: AppFontSize.iconButton.value,
            color: context.colorScheme.background,
          ),
        ),
      ),
    );
  }
}
