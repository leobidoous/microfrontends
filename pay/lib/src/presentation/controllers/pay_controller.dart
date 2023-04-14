import 'package:core/core.dart';

class PayController extends GenController<Exception, Unit> {
  PayController({required this.session}) : super(unit);

  final SessionEntity session;
}
