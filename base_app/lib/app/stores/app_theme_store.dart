import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppThemeStore extends NotifierStore<Exception, ThemeMode> {
  final IPreferencesStorageDriver preferencesDriver;

  AppThemeStore({
    required this.preferencesDriver,
  }) : super(ThemeMode.light);

  Future<void> getStorageTheme() async {
    setLoading(true);
    await preferencesDriver.getStringByKey(key: 'ThemeMode').then(
      (value) {
        value.fold(
          (l) => l,
          (r) {
            switch (r) {
              case 'system':
                update(ThemeMode.system);
                break;
              case 'dark':
                update(ThemeMode.dark);
                break;
              case 'light':
                update(ThemeMode.light);
                break;
            }
          },
        );
      },
    ).whenComplete(() => setLoading(false));
  }

  Future<void> changeThemeType(ThemeMode type) async {
    setLoading(false);
    await preferencesDriver
        .setStringByKey(key: 'ThemeMode', value: type.name.toString())
        .then((value) {
      value.fold(
        (l) => setError(l),
        (r) => update(type),
      );
    });
    setLoading(false);
  }
}
