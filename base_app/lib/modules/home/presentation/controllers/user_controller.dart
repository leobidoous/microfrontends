import 'package:core/core.dart';

import '../../../app/domain/usecases/user_usecase.dart';

class UserController extends DefaultController<Exception, UserEntity> {
  final IUserUsecase userUsecase;
  final ILocalUserUsecase localUserUsecase;

  UserController(
    super.value, {
    required this.userUsecase,
    required this.localUserUsecase,
  });

  Future<void> updateUser() async {
    setLoading(true);
    final localUser = await userUsecase.getUserById(id: state.id);
    return localUser.fold((l) => setError(l), (user) async {
      final response = await localUserUsecase.setLocalUser(user: user);
      return response.fold((l) => setError(l), (r) => update(user));
    });
  }
}
