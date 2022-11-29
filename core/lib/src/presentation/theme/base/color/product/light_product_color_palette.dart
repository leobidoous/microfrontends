import 'package:flutter/material.dart';

import 'product_color_palette.dart';

///
/// Products color palette definition for Light theme.
///
class LightProductColorPalette implements IProductColorPalette {
  @override
  Color get privatePension => const Color(0xffBCBEC8);

  @override
  Color get treasure => const Color(0xff37DDF6);

  @override
  Color get fixedIncome => const Color(0xff38A8FF);

  @override
  Color get funds => const Color(0xff5D65F7);

  @override
  Color get variableIncome => const Color(0xff2936C4);

  @override
  Color get stocksFutures => const Color(0xff9C27B0);

  @override
  Color get structured => const Color(0xffE91E63);
}
