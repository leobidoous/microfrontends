import 'package:flutter/material.dart';

import '../../../../shared/domain/interfaces/either.dart';
import '../../../../shared/domain/interfaces/gen_controller.dart';
import '../../domain/usecases/i_local_user_usecase.dart';

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
