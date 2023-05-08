import 'package:core/core.dart';
import 'package:flutter/material.dart';

  
class BankCard extends StatelessWidget {

  const BankCard({
    Key? key,
    required this.institution,
    required this.onTap,
  }) : super(key: key);

  final Map institution;
  final Function() onTap;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: EdgeInsets.only(
        bottom: const Spacing(2).value,
      ),
      padding: EdgeInsets.all(
        const Spacing(1).value,
      ),
      decoration: BoxDecoration(
        color: AppColorsBase.neutrla0,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: context.colorScheme.outlineVariant,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.network(
              institution['iconLogo'],
              width: 48,
            ),
            const Spacing(1).horizontal,
            Text(
              institution['displayName'],
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColorsBase.neutrla7,
                fontWeight: context.textTheme.fontWeightBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
