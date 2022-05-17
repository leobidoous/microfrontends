import 'dart:developer';

import 'package:core/core.dart';

import '../../../../core/enums/login_type.dart';
import '../../domain/entities/login/login_with_email_entity.dart';
import '../../domain/entities/login/login_with_phone_entity.dart';
import '../../domain/usecases/login/login_with_email.dart';
import '../../domain/usecases/login/login_with_phone.dart';
import 'login_type_store.dart';

class LoginStore extends NotifierStore<Exception, bool>  {
  final ILoginWithEmailUsecase emailUsecase;
  final ILoginWithPhoneUsecase phoneUsecase;

  final LoginTypeStore typeStore;

  LoginStore({
    required this.emailUsecase,
    required this.phoneUsecase,
    required this.typeStore,
  }) : super(false);

  Future<void> login({
    required String identify,
    required String password,
  }) async {
    setLoading(true);

    switch (typeStore.state) {
      case LoginType.email:
        await emailUsecase(
          login: LoginWithEmailEntity(email: identify, password: password),
        ).then((value) {
          value.fold((l) => setError(l), (r) => update(true));
        });
        break;
      case LoginType.phone:
        await phoneUsecase(
          login: LoginWithPhoneEntity(phone: identify, password: password),
        ).then((value) {
          value.fold((l) => setError(l), (r) => update(true));
        });
        break;
    }
    setLoading(false);
  }

}
