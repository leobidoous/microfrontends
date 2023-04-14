import 'package:core/core.dart';

class ParkingController extends GenController<Exception, Unit> {
  ParkingController({required this.session}) : super(unit);

  final SessionEntity session;
}
