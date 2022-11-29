import 'package:flutter/material.dart';

import 'product_color_palette.dart';

///
/// Products color palette definition for Dark theme.
///
class DarkProductColorPalette implements IProductColorPalette {
  @override
  Color get privatePension => const Color(0xffDDDEE4);

  @override
  Color get treasure => const Color(0xff4CE6FA);

  @override
  Color get fixedIncome => const Color(0xff53BAFF);

  @override
  Color get funds => const Color(0xff7E80FB);

  @override
  Color get variableIncome => const Color(0xff3F4CEB);

  @override
  Color get stocksFutures => const Color(0xffAB47BC);

  @override
  Color get structured => const Color(0xffEC407A);
}
