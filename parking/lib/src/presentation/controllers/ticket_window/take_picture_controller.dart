import 'dart:io';

import 'package:core/core.dart';

class TakePictureController extends GenController<List<Exception>, File> {
  TakePictureController() : super(File(''));

  void onUpdateValue(File file) {
    update(file);
  }
}
