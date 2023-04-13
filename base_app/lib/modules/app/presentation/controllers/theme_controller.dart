import 'package:core/core.dart';
import 'package:flutter/material.dart';


class ThemeController extends GenController<Exception, ThemeMode> {
  final ILocalUserUsecase localUserUsecase;

  ThemeController({required this.localUserUsecase}) : super(ThemeMode.system);

  Future<void> getLocalTheme() async {
    execute(() => localUserUsecase.getThemeMode());
  }

  Future<void> onChangeTheme(ThemeMode mode) async {
    execute(
      () => localUserUsecase.setThemeMode(themeMode: mode).then(
            (value) => value.fold((l) => Left(l), (r) => Right(mode)),
          ),
    );
  }
}
