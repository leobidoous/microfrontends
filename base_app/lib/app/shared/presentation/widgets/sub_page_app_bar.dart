import 'package:flutter/material.dart';

class SubPageAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const SubPageAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Navigator.of(context).pop,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
