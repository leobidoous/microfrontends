import 'package:flutter/material.dart';

class GenLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const GenLogo({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logos/gen_logotype_light.png',
      width: width ?? 224.0,
      height: height ?? 87.0,
    );
  }
}
