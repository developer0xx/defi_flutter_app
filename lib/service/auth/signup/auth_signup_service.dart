import 'package:sapiency_app/model/api/signup/available/req/signup_available_req.dart';
import 'package:sapiency_app/model/api/signup/available/res/signup_available_res.dart';
import 'package:sapiency_app/model/api/signup/step/confirm/req/signup_step_confirm_req.dart';
import 'package:sapiency_app/model/api/signup/step/confirm/res/signup_step_confirm_res.dart';
import 'package:sapiency_app/model/api/signup/step/create/req/signup_step_create_req.dart';
import 'package:sapiency_app/model/api/signup/step/create/res/signup_step_create_res.dart';
import 'package:sapiency_app/model/api/user/signup/req/user_signup_req.dart';
import 'package:sapiency_app/model/api/user/signup/res/user_signup_res.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/auth/exception/signup/auth_start_sign_up_exception.dart';
import 'package:sapiency_app/service/auth/exception/step/create/auth_step_exception.dart';

class AuthSignupService {
  static const _consents = ['marketing', 'sapiency-1'];
  static const _emailStepId = 'EMAIL';
  static const _phoneStepId = 'PHONE';

  final ApiService _apiService;

  const AuthSignupService(this._apiService);

  Future<void> startSignUp({required String email, required String nickname, required String password}) async {
    final nicknameResponse = await _apiService.signupAvailable(SignupAvailableReq.nickname(nickname: nickname));
    if (nicknameResponse.body is SignupAvailableResError) throw AuthStartSignUpException.nicknameExists();
    final emailResponse = await _apiService.signupAvailable(SignupAvailableReq.email(email: email));
    if (emailResponse.body is SignupAvailableResError) throw AuthStartSignUpException.emailExists();
    final response = await _apiService.userSignup(UserSignupReq(
      nickname: nickname,
      password: password,
      consents: _consents,
      language: 'en',
    ));
    if (response.body is UserSignupResError) throw AuthStartSignUpException.unknown();
  }

  Future<void> sendVerificationEmail({required String email, required String nickname}) async {
    final response = await _apiService.signupStepCreate(
      _emailStepId,
      SignupStepCreateReq.email(
        nickname: nickname,
        email: email,
      ),
    );
    if (response.body is SignupStepCreateResError) throw AuthStepException();
  }

  Future<void> confirmVerificationEmail({
    required String nickname,
    required String email,
    required String pin,
  }) async {
    final response = await _apiService.signupStepConfirm(
      _emailStepId,
      SignupStepConfirmReq.email(
        nickname: nickname,
        email: email,
        pin: pin,
      ),
    );
    if (response.body is SignupStepConfirmResError) throw AuthStepException();
  }

  Future<void> sendVerificationPhone({required String nickname, required String phone}) async {
    final response = await _apiService.signupStepCreate(
      _phoneStepId,
      SignupStepCreateReq.phone(nickname: nickname, phone: phone),
    );
    if (response.body is SignupStepCreateResError) throw AuthStepException();
  }

  Future<void> confirmVerificationPhone({required String nickname, required String phone, required String pin}) async {
    final response = await _apiService.signupStepConfirm(
      _phoneStepId,
      SignupStepConfirmReq.phone(nickname: nickname, phone: phone, pin: pin),
    );
    if (response.body is SignupStepConfirmResError) throw AuthStepException();
  }
}
