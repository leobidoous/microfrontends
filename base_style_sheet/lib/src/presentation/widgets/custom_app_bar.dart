import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leadingIcon,
    this.title,
    this.actions,
    this.backgroundColor,
    this.onBackTap,
    this.toolbarHeight,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
  });

  final Widget? leadingIcon;
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final bool centerTitle;
  final bool automaticallyImplyLeading;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size(double.infinity, toolbarHeight ?? AppThemeBase.appBarHeight);

  factory CustomAppBar.zero() {
    return const CustomAppBar(
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
    );
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
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
            backgroundColor:
                widget.backgroundColor ?? context.colorScheme.background,
            title: Text(
              widget.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: context.textTheme.fontWeightMedium,
                color: AppColorsBase.neutrla7,
              ),
            ),
            leading: widget.automaticallyImplyLeading
                ? Semantics(
                    button: true,
                    child: SizedBox(
                      height: const Spacing(3).value,
                      width: const Spacing(3).value,
                      child: InkWell(
                        onTap: widget.onBackTap ?? Nav.to.pop,
                        borderRadius: AppThemeBase.borderRadiusSM,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: const Spacing(2).value,
                            horizontal: const Spacing(4).value,
                          ),
                          child: (widget.leadingIcon != null)
                              ? widget.leadingIcon
                              : Icon(
                                  CoreIcons.chevronLeft,
                                  color: AppColorsBase.neutrla7,
                                ),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
