import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ThemeController extends GenController<Exception, ThemeMode> {
  final ILocalUserUsecase localUserUsecase;

  ThemeController({required this.localUserUsecase}) : super(ThemeMode.light);

  Future<void> getLocalTheme() async {
    await execute(() => localUserUsecase.getThemeMode());
  }

  Future<void> onChangeTheme(ThemeMode mode) async {
    await execute(
      () => localUserUsecase.setThemeMode(themeMode: mode).then(
            (value) => value.fold((l) => Left(l), (r) => Right(mode)),
          ),
    );
  }
}
