import 'package:core/core.dart';

import '../../../domain/entities/gen_desk/faq_entity.dart';
import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../domain/repositories/gen_desk/i_desk_repository.dart';
import '../../../domain/usecases/gen_desk/i_desk_usecase.dart';

class DeskUsecase extends IDeskUsecase {
  final IDeskRepository repository;
  final SessionEntity session;

  DeskUsecase({required this.session, required this.repository});

  @override
  Future<Either<Exception, List<FAQEntity>>> fetchFAQs() {
    return repository.fetchFAQs();
  }

  @override
  Future<Either<Exception, DeskCardStatus>> fetchParkingReleaseStatus() {
    return repository.fetchParkingReleaseStatus(
      marketplaceId: session.claims.marketplaceId,
      customerId: session.customer.id,
    );
  }
}
