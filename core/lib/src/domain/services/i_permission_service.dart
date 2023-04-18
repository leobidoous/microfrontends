import '../enums/permission_status_type_enum.dart';
import '../enums/permission_type_enum.dart';
import '../interfaces/either.dart';

abstract class IPermissionService {
  Future<Either<Exception, PermissionStatusType>> requestPermisison({
    required PermissionType permission,
  });
  Future<Either<Exception, PermissionStatusType>> onCheckPermisisonStatus({
    required PermissionType permission,
  });
}
