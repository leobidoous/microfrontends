import 'package:permission_handler/permission_handler.dart';

import '../../domain/enums/permission_status_type_enum.dart';
import '../../domain/enums/permission_type_enum.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_permission_service.dart';

class PermissionService extends IPermissionService {
  @override
  Future<Either<Exception, PermissionStatusType>> onCheckPermisisonStatus({
    required PermissionType permission,
  }) async {
    try {
      late final PermissionStatus response;
      switch (permission) {
        case PermissionType.location:
          response = await Permission.location.status;
          break;
        default:
          break;
      }
      return Right(permissionStatusTypeFromType(response.name));
    } catch (e) {
      return Left(Exception());
    }
  }

  @override
  Future<Either<Exception, PermissionStatusType>> requestPermisison({
    required PermissionType permission,
  }) async {
    try {
      late final PermissionStatus response;
      switch (permission) {
        case PermissionType.location:
          response = await Permission.location.request();
          break;
        case PermissionType.calendar:
          response = await Permission.location.request();
          break;
        case PermissionType.mediaLibrary:
          response = await Permission.location.request();
          break;
        case PermissionType.camera:
          response = await Permission.location.request();
          break;
        default:
          break;
      }
      return Right(permissionStatusTypeFromType(response.name));
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
