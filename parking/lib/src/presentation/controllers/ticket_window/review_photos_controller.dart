import 'dart:io';

import 'package:core/core.dart';

class ReviewPhotosController
    extends GenController<List<Exception>, List<File>> {
  ReviewPhotosController() : super([]);

  void onAddValue(File value) {
    final values = List<File>.from(state, growable: true);
    values.insert(0, value);
    update(values);
  }

  void onRemoveValue(File value) {
    final values = List<File>.from(state, growable: true);
    values.removeWhere((element) => element == value);
    update(values);
  }

  void onClear() {
    state.clear();
  }
}
