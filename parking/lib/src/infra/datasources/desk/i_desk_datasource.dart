import 'package:core/core.dart';

import '../../../domain/entities/desk/faq_entity.dart';
import '../../../domain/enums/desk_cart_status_enum.dart';

abstract class IDeskDatasource {
  Future<Either<Exception, List<FAQEntity>>> fetchFAQs();
  Future<Either<Exception, DeskCardStatus>> fetchParkingReleaseStatus();
}