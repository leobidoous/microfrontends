import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        Animation,
        AnimationController,
        BorderRadius,
        BuildContext,
        Center,
        ClipRRect,
        Column,
        CrossAxisAlignment,
        CurvedAnimation,
        Curves,
        DecoratedBox,
        Key,
        LinearProgressIndicator,
        MainAxisAlignment,
        SizedBox,
        TickerProviderStateMixin,
        Transform,
        Tween,
        Widget;


enum LoadingType { primary, linear }

class GenLoading extends StatefulWidget {
  final LoadingType type;
  final double width;
  final double height;
  final Duration duration;
  final Widget Function(BuildContext, int)? itemBuilder;
  const GenLoading({
    Key? key,
    this.type = LoadingType.primary,
    this.width = 40,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
    this.height = 40,
  }) : super(key: key);

  @override
  State<GenLoading> createState() => _GenLoadingState();
}

class _GenLoadingState extends State<GenLoading> with TickerProviderStateMixin {
  late AnimationController scaleCtrl;
  late AnimationController rotateCtrl;
  late Animation<double> scale;
  late Animation<double> rotate;

  @override
  void initState() {
    super.initState();

    scaleCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);
    scale = Tween(begin: -1.0, end: 1.0)
        .animate(CurvedAnimation(parent: scaleCtrl, curve: Curves.easeInOut));

    rotateCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..repeat();
    rotate = Tween(begin: 0.0, end: 360.0)
        .animate(CurvedAnimation(parent: rotateCtrl, curve: Curves.linear));
  }

  @override
  void dispose() {
    scaleCtrl.dispose();
    rotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.type == LoadingType.linear
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.type == LoadingType.linear)
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: const LinearProgressIndicator(minHeight: .5),
          ),
        if (widget.type == LoadingType.primary)
          Center(
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: Transform.rotate(
                angle: rotate.value * 0.0174533,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0,
                      child: _circle(
                        1.0 - scale.value.abs(),
                        0,
                        context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: _circle(
                        scale.value.abs(),
                        1,
                        context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _circle(double scale, int index, Color color) {
    return Transform.scale(
      scale: scale,
      child: SizedBox.fromSize(
        size: Size.square(widget.height * 0.6),
        child: widget.itemBuilder != null
            ? widget.itemBuilder!(context, index)
            : DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
      ),
    );
  }
}
