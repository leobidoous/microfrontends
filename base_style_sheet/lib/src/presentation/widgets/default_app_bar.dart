import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        Border,
        BorderSide,
        BoxDecoration,
        BuildContext,
        DecoratedBox,
        EdgeInsets,
        Icon,
        Icons,
        InkWell,
        Key,
        Padding,
        PreferredSizeWidget,
        Row,
        Size,
        State,
        StatefulWidget,
        VoidCallback,
        Widget;


class DefaultAppBar extends StatefulWidget with PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final double leadingWidth;
  final List<Widget> actions;
  final VoidCallback? onTapTittle;
  final bool automaticallyImplyLeading;

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
  State<DefaultAppBar> createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, AppThemeBase.appBarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      child: InkWell(
        onTap: widget.onTapTittle,
        child: AppBar(
          primary: true,
          title: widget.title,
          leading: widget.automaticallyImplyLeading
              ? Nav.to.canPop()
                  ? InkWell(
                      onTap: Nav.to.pop,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 24,
                          color: context.colorScheme.background,
                        ),
                      ),
                    )
                  : null
              : widget.leading,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          surfaceTintColor: context.colorScheme.primary,
          backgroundColor: context.colorScheme.primary,
          leadingWidth: widget.leadingWidth,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: widget.actions),
            ),
          ],
        ),
      ),
    );
  }
}
