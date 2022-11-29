import 'package:flutter/material.dart';

///
/// Color palette definition for Products.
///
abstract class IProductColorPalette {
  /// Private pension color
  Color get privatePension;

  /// Treasure color
  Color get treasure;

  /// Fixed income color
  Color get fixedIncome;

  /// Funds color
  Color get funds;

  /// Variable income color
  Color get variableIncome;

  /// Stocks and Futures color
  Color get stocksFutures;

  /// Structured investments color
  Color get structured;
}
