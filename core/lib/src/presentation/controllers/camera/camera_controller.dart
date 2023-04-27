import 'package:camera/camera.dart';

import '../../../core/helpers/errors/print_exception.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/interfaces/gen_controller.dart';

class CamController
    extends GenController<CameraException, List<CameraDescription>> {
  CameraController? cameraController;

  CamController() : super(const []);

  Future<void> fetchCameras() async {
    setLoading(true);
    await availableCameras()
        .then((value) => update(value))
        .catchError((onError) => setError(CameraException('', '')))
        .whenComplete(() => setLoading(false));
  }

  Future<void> initialize() async {
    setLoading(true);
    late final CameraDescription cam;
    if (state.any((cam) => cam.lensDirection == CameraLensDirection.back)) {
      cam = state.firstWhere(
        (e) => e.lensDirection == CameraLensDirection.back,
      );
    } else if (state.isNotEmpty) {
      cam = state.last;
    } else {
      setError(CameraException('', ''));
      return;
    }
    try {
      cameraController = CameraController(
        cam,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController?.initialize();
    } on CameraException catch (e, s) {
      printException(exception: e, stackTrace: s);
      setError(e);
      printException(exception: e, stackTrace: s);

      setError(CameraException('', e.toString()));
    }
    setLoading(false);
  }

  Future<Either<CameraException, XFile>> takePicture() async {
    try {
      final pic = await cameraController?.takePicture();
      if (pic != null) return Right(pic);
      return Left(CameraException('', ''));
    } on CameraException catch (e, s) {
      printException(exception: e, stackTrace: s);
      return Left(e);
    }
  }
}
