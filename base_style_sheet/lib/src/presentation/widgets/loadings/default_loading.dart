import 'package:flutter/material.dart';

enum LoadingType { primary, linear }

class DefaultLoading extends StatelessWidget {
  final LoadingType type;
  final double? width;
  final double? height;
  const DefaultLoading({
    Key? key,
    this.type = LoadingType.primary,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: type == LoadingType.linear
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (type == LoadingType.linear)
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: const LinearProgressIndicator(minHeight: .5),
          ),
        if (type == LoadingType.primary)
          SizedBox(
            width: width,
            height: height,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          ),
      ],
    );
  }
}
