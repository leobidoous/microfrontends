import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GenAppBar extends StatefulWidget with PreferredSizeWidget {
  const GenAppBar({
    super.key,
    this.leadingIcon,
    this.title,
    this.actions,
    this.backgroundColor,
    this.onBackTap,
    this.toolbarHeight,
    this.showDivider = true,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
  });

  final Widget? leadingIcon;
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final Color? backgroundColor;
  final bool showDivider;
  final double? toolbarHeight;
  final bool centerTitle;
  final bool automaticallyImplyLeading;

  @override
  State<GenAppBar> createState() => _GenAppBarState();

  @override
  Size get preferredSize =>
      Size(double.infinity, toolbarHeight ?? AppThemeBase.appBarHeight);

  factory GenAppBar.zero() {
    return const GenAppBar(
      toolbarHeight: 0,
      showDivider: false,
      automaticallyImplyLeading: false,
    );
  }
}

class _GenAppBarState extends State<GenAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: AppBar(
            elevation: 0,
            actions: widget.actions,
            centerTitle: widget.centerTitle,
            toolbarHeight: widget.toolbarHeight,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            backgroundColor: widget.backgroundColor ?? Colors.transparent,
            title: Text(
              widget.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightMedium,
                color: context.colorScheme.onBackground,
              ),
            ),
            leading: widget.automaticallyImplyLeading
                ? Nav.to.canPop()
                    ? Semantics(
                        button: true,
                        child: SizedBox(
                          height: const Spacing(3).value,
                          width: const Spacing(3).value,
                          child: InkWell(
                            onTap: widget.onBackTap ?? Nav.to.pop,
                            borderRadius: AppThemeBase.borderRadiusSM,
                            child: Padding(
                              padding: EdgeInsets.all(const Spacing(2).value),
                              child: (widget.leadingIcon != null)
                                  ? widget.leadingIcon
                                  : Icon(
                                      Icons.arrow_back_ios,
                                      color: context.colorScheme.onBackground,
                                    ),
                            ),
                          ),
                        ),
                      )
                    : null
                : SizedBox(
                    height: const Spacing(3).value,
                    width: const Spacing(3).value,
                    child: widget.leadingIcon,
                  ),
          ),
        ),
        if (widget.showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: const Spacing(6).value),
            child: Divider(
              height: 0,
              color: AppColorsBase.grey3,
              thickness: context.textTheme.lineHeightRegular,
            ),
          )
      ],
    );
  }
}
