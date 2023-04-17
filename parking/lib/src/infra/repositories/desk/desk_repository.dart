import 'package:core/core.dart';

import '../../../domain/entities/desk/faq_entity.dart';
import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../domain/repositories/desk/i_desk_repository.dart';
import '../../datasources/desk/i_desk_datasource.dart';

class DeskRepository extends IDeskRepository {
  final IDeskDatasource datasource;

  DeskRepository({required this.datasource});

  @override
  Future<Either<Exception, List<FAQEntity>>> fetchFAQs() {
    return datasource.fetchFAQs();
  }

  @override
  Future<Either<Exception, DeskCardStatus>> fetchParkingReleaseStatus() {
    return datasource.fetchParkingReleaseStatus();
  }
}
