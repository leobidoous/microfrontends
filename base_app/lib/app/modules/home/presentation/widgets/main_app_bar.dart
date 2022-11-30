import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainAppBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      child: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const Icon(Icons.abc, size: 40),
        ),
        surfaceTintColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leadingWidth: 64,
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
