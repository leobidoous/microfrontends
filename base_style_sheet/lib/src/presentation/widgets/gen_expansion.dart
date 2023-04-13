import 'package:core/core.dart';
import 'package:flutter/material.dart';


class GenExpansion<T> extends StatefulWidget {
  final bool showDivider;
  final Widget title;
  final Widget body;
  final T value;
  final bool isSelected;
  final Function(T)? onTap;
  const GenExpansion({
    super.key,
    this.onTap,
    required this.body,
    required this.value,
    this.isSelected = false,
    required this.title,
    this.showDivider = true,
  });

  @override
  State<GenExpansion<T>> createState() => _GenExpansionState<T>();
}

class _GenExpansionState<T> extends State<GenExpansion<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  late final Animation<double> rotateAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    rotateAnimation = Tween<double>(begin: 1, end: .5).animate(
      animationController,
    );
  }

  @override
  void didUpdateWidget(covariant GenExpansion<T> oldWidget) {
    if (!widget.isSelected && animationController.isCompleted) {
      animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (animationController.isCompleted) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
        widget.onTap?.call(widget.value);
      },
      child: AnimatedBuilder(
        animation: animationController,
        child: widget.body,
        builder: (_, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: widget.title),
                  Spacing.sm.horizontal,
                  RotationTransition(
                    turns: rotateAnimation,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColorsBase.neutrla5,
                      size: const Spacing(3).value,
                    ),
                  ),
                ],
              ),
              FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, child: child!),
              ),
              if (widget.showDivider) const Divider(height: 0),
            ],
          );
        },
      ),
    );
  }
}
