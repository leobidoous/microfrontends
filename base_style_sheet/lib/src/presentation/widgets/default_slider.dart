import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DefaultSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final Function(double)? onChanged;
  const DefaultSlider({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 1000,
    this.onChanged,
  });

  @override
  State<DefaultSlider> createState() => _DefaultSliderState();
}

class _DefaultSliderState extends State<DefaultSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: context.theme.sliderTheme.copyWith(
        overlayShape: null,
        minThumbSeparation: 10,
      ),
      child: Slider(
        min: widget.min / widget.max,
        thumbColor: Colors.blue,
        value: widget.value,
        onChanged: widget.onChanged,
      ),
    );
  }
}
