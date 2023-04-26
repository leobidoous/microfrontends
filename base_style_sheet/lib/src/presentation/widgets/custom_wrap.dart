import 'package:flutter/material.dart'
    show
        BuildContext,
        LayoutBuilder,
        SizedBox,
        StatelessWidget,
        Widget,
        Wrap,
        WrapAlignment;

class CustomWrap<T> extends StatelessWidget {
  final int? nCols;
  final List<Widget> items;
  final double spacing;
  final WrapAlignment wrapAlignment;

  const CustomWrap({
    super.key,
    this.nCols,
    this.wrapAlignment = WrapAlignment.start,
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
          alignment: wrapAlignment,
          children: items.map((item) {
            return SizedBox(
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
