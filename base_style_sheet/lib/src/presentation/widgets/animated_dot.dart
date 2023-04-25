import 'package:core/core.dart';
import 'package:flutter/material.dart';

enum DotState { opened, closed }

class AnimatedDot extends StatefulWidget {
  final bool selected;
  final VoidCallback? callback;

  const AnimatedDot({
    Key? key,
    this.callback,
    this.selected = false,
  }) : super(key: key);
  @override
  _AnimatedDotState createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(milliseconds: 250);
  late final Animation<double> scaleAnimation;
  late final AnimationController controller;
  late DotState currentState;

  @override
  void initState() {
    currentState = widget.selected ? DotState.opened : DotState.closed;
    controller = AnimationController(vsync: this, duration: duration);
    controller.addListener(() {
      final double controllerValue = controller.value;
      if (controllerValue < 0.2) {
        currentState = DotState.closed;
      } else if (controllerValue > 0.8) {
        currentState = DotState.opened;
      }
    });
    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedDot oldWidget) {
    currentState = widget.selected ? DotState.opened : DotState.closed;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: AnimatedContainer(
        duration: duration,
        decoration: BoxDecoration(
          color: widget.selected
              ? context.colorScheme.primary
              : AppColorsBase.neutrla2,
          borderRadius: BorderRadius.circular(const Spacing(.25).value),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: AnimatedSize(
          curve: Curves.easeIn,
          duration: duration,
          child: SizedBox(
            height: const Spacing(1).value,
            width: widget.selected
                ? const Spacing(3).value
                : const Spacing(1).value,
          ),
        ),
      ),
    );
  }
}
