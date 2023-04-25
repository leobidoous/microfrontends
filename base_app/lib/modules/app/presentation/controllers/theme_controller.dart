import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ThemeController extends GenController<Exception, ThemeMode> {
  final ILocalUserUsecase localUserUsecase;

  ThemeController({required this.localUserUsecase}) : super(ThemeMode.light);
}
