import 'package:core/core.dart';

import '../../entities/desk/faq_entity.dart';
import '../../enums/desk_cart_status_enum.dart';

abstract class IDeskRepository {
  Future<Either<Exception, List<FAQEntity>>> fetchFAQs();
  Future<Either<Exception, DeskCardStatus>> fetchParkingReleaseStatus();
}