import 'package:core/core.dart';

import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../domain/usecases/desk/i_desk_usecase.dart';

class GenDeskController extends GenController<Exception, DeskCardStatus> {
  final IDeskUsecase usecase;
  GenDeskController({required this.usecase}) : super(DeskCardStatus.initial);

  void fetchParkingReleaseStatus() {
    execute(() => usecase.fetchParkingReleaseStatus());
  }
}
