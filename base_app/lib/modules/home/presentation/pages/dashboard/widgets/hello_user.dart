import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HelloUser extends StatelessWidget {
  const HelloUser({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final breakName = name.trim().split(' ');

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Olá!\n',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: context.textTheme.secodaryFontFamily,
                height: 1,
                fontSize: AppFontSize.bodyLarge.value,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${breakName.first} ${breakName.last}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontFamily: context.textTheme.secodaryFontFamily,
                    fontWeight: AppFontWeight.bold.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
