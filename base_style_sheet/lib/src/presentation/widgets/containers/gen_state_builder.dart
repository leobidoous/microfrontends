import 'package:flutter/material.dart';

import '../../../domain/interfaces/gen_controller.dart';

class GenStateBuilder<T, E, S> extends StatelessWidget {
  final Widget Function(BuildContext, S, bool, E?) builder;
  final GenController<E, S> controller;

  const GenStateBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<S>(
      valueListenable: controller,
      builder: (context, value, child) {
        return builder(
          context,
          value,
          controller.isLoading,
          controller.error,
        );
      },
    );
  }
}
