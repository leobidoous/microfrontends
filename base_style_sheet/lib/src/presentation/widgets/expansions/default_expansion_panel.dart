import 'package:flutter/material.dart';

class DefaultExpansionItem<T> extends StatefulWidget {
  final T value;
  final Widget title;
  final Widget body;
  final bool isSelected;
  final bool isActive;
  final bool canAddOrRemoveByTap;
  final Function(T?)? onCollapse;
  final Function(T)? onSelect;

  const DefaultExpansionItem({
    Key? key,
    required this.title,
    required this.value,
    required this.body,
    this.onCollapse,
    this.onSelect,
    this.isSelected = false,
    this.isActive = false,
    this.canAddOrRemoveByTap = false,
  }) : super(key: key);

  @override
  State<DefaultExpansionItem<T>> createState() =>
      _DefaultExpansionItemState<T>();
}

class _DefaultExpansionItemState<T> extends State<DefaultExpansionItem<T>>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final duration = const Duration(milliseconds: 250);
  late final Animation<double> collapseAnimation;
  late final Animation<double> selectAnimation;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    collapseAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    selectAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DefaultExpansionItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !widget.canAddOrRemoveByTap) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: () {
        if (widget.canAddOrRemoveByTap) {
          widget.onSelect?.call(widget.value);
        } else {
          if (controller.isDismissed) {
            controller.forward();
          } else {
            controller.reverse();
          }
          widget.onCollapse?.call(widget.isActive ? null : widget.value);
        }
      },
      onLongPress: () {
        if (widget.canAddOrRemoveByTap) {
          return;
        }
        widget.onCollapse?.call(null);
        widget.onSelect?.call(widget.value);
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).backgroundColor,
              spreadRadius: -1.5,
              blurRadius: 2.5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: AnimatedBuilder(
          animation: collapseAnimation,
          builder: (_, child) {
            final body = Tween<double>(begin: 0, end: 1).animate(
              collapseAnimation,
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.title,
                if (!controller.isDismissed) ...[
                  FadeTransition(
                    opacity: body,
                    child: SizeTransition(
                      sizeFactor: body,
                      child: Divider(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        height: 32,
                      ),
                    ),
                  ),
                ],
                FadeTransition(
                  opacity: body,
                  child: SizeTransition(sizeFactor: body, child: child),
                ),
              ],
            );
          },
          child: widget.body,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.isSelected || !widget.isActive;
}
