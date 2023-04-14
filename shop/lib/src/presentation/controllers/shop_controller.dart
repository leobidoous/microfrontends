import 'package:core/core.dart';

class ShopController extends GenController<Exception, Unit> {
  ShopController({required this.session}) : super(unit);

  final SessionEntity session;
}
