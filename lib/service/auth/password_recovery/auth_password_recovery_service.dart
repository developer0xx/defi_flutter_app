import 'package:sapiency_app/model/api/user/password_recovery/confirm/req/user_password_recovery_confirm_req.dart';
import 'package:sapiency_app/model/api/user/password_recovery/req/user_password_recovery_req.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/auth/exception/password_recovery/auth_password_recovery_exception.dart';
import 'package:sapiency_app/service/auth/exception/password_recovery/confirm/auth_password_recovery_confirm_exception.dart';

class AuthPasswordRecoveryService {
  final ApiService _apiService;

  const AuthPasswordRecoveryService(this._apiService);

  Future<void> initPasswordRecovery(String email) async {
    final response = await _apiService.userPasswordRecovery(UserPasswordRecoveryReq(email: email));
    return response.body!.when<void>(
      ok: () {},
      error: () => throw AuthPasswordRecoveryException(),
    );
  }

  Future<void> confirmPasswordRecovery({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    final response = await _apiService.userPasswordRecoveryConfirm(
      UserPasswordRecoveryConfirmReq(
        email: email,
        code: code,
        password: newPassword,
      ),
    );
    return response.body!.when<void>(
      ok: () {},
      error: () => throw AuthPasswordRecoveryConfirmException(),
    );
  }
}
