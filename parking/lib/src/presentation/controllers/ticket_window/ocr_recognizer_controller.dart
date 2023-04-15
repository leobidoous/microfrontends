import 'dart:io';

import 'package:core/core.dart';

import '../../../domain/usecases/ticket_window/i_ticket_window_usecase.dart';

class OcrRecognizerController
    extends GenController<List<Exception>, List<File>> {
  OcrRecognizerController({required this.usecase}) : super(const []);

  final ITicketWindowUsecase usecase;

  Future<void> recognizePhotos(List<File> files) async {
    for (File file in files) {
      await execute(
        () => usecase.onOcrRecognizer().then((value) {
          return value.fold(
            (l) {
              final errors = error?..add(l);
              return Left(errors ?? []);
            },
            (r) {
              final files = state..add(file);
              return Right(files);
            },
          );
        }),
      );
    }
  }
}
