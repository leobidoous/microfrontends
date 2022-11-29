import 'package:core/core.dart' show ObjectScreenShot;
import 'package:flutter/material.dart';

/// [ScreenShotBuilder] to componentize screen shot widget
class ScreenShotBuilder extends StatefulWidget {
  /// [padding] attribute
  final EdgeInsets padding;

  /// [screenKey] for a external implementation of the
  /// [ObjectScreenShot.take] method.
  final GlobalKey? screenKey;

  /// [builder] to build widget child
  final Widget Function(
    BuildContext,
    Future<void> Function({String filename}),
  ) builder;

  /// [ScreenShotBuilder] to componentize screen shot widget
  const ScreenShotBuilder({
    Key? key,
    this.screenKey,
    this.padding = EdgeInsets.zero,
    required this.builder,
  }) : super(key: key);

  @override
  State<ScreenShotBuilder> createState() => _ScreenShotBuilderState();
}

class _ScreenShotBuilderState extends State<ScreenShotBuilder> {
  late final GlobalKey screenKey;

  @override
  void initState() {
    super.initState();
    screenKey = widget.screenKey ?? GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: screenKey,
      child: Padding(
        padding: widget.padding,
        child: widget.builder(
          context,
          ({String filename = 'file'}) async {
            await ObjectScreenShot.take(
              key: screenKey,
              context: context,
              filename: filename,
            );
          },
        ),
      ),
    );
  }
}
