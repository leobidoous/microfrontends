import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final double leadingWidth;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final VoidCallback? onTapTittle;

  const DefaultAppBar({
    Key? key,
    this.title,
    this.leading,
    this.onTapTittle,
    this.automaticallyImplyLeading = false,
    this.leadingWidth = 64,
    this.actions = const [],
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
      child: InkWell(
        onTap: onTapTittle,
        child: AppBar(
          primary: true,
          title: SizedBox(
            height: 50,
            child: title ?? const Icon(CoreIcons.home),
          ),
          leading: automaticallyImplyLeading
              ? InkWell(
                  onTap: Navigator.of(context).pop,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      CoreIcons.chevronLeft,
                      size: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                )
              : leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          surfaceTintColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          leadingWidth: leadingWidth,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: actions),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
