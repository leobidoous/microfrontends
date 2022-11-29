import 'package:flutter/material.dart';

class DefaultWrap<T> extends StatelessWidget {
  final int? nCols;
  final List<Widget> items;
  final double spacing;

  const DefaultWrap({
    super.key,
    this.nCols,
    this.spacing = 8,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Wrap(
          runSpacing: 8,
          spacing: spacing,
          children: items.map((item) {
            return Container(
              alignment: nCols != null ? Alignment.centerLeft : null,
              width: nCols != null
                  ? constrains.maxWidth / nCols! -
                      (spacing * (nCols! - 1)) / nCols!
                  : null,
              child: item,
            );
          }).toList(),
        );
      },
    );
  }
}
