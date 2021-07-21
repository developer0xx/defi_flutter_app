import 'package:sapiency_app/model/api/user/login/email/req/user_login_email_req.dart';
import 'package:sapiency_app/model/api/user/login/pin/req/user_login_pin_req.dart';
import 'package:sapiency_app/model/api/user/login/pin/res/user_login_pin_res.dart';
import 'package:sapiency_app/model/api/user/login/pin/set/req/user_login_pin_set_req.dart';
import 'package:sapiency_app/model/api/user/login/pin/set/res/user_login_pin_set_res.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/api/client/api_client_service.dart';
import 'package:sapiency_app/service/auth/login/exception/auth_login_exception.dart';
import 'package:sapiency_app/service/device/device_service.dart';

class AuthLoginService {
  static const _pin = '1111';

  final ApiService _apiService;
  final ApiClientService _apiClientService;
  final DeviceService _deviceService;

  const AuthLoginService(this._apiService, this._apiClientService, this._deviceService);

  Future<void> loginEmail({required String email, required String password}) async {
    final emailResponse = await _apiService.userLoginEmail(UserLoginEmailReq(email: email, password: password));
    final emailToken = emailResponse.body!.when(ok: (token) => token, error: () => throw AuthLoginException());
    await _apiClientService.storeAuthToken(emailToken);
    final deviceId = await _deviceService.obtainDeviceId();
    final pinSetResponse = await _apiService.userLoginPinSet(UserLoginPinSetReq(
      email: email,
      password: password,
      deviceId: deviceId,
      pin: _pin,
    ));
    if (pinSetResponse is UserLoginPinSetResError) throw AuthLoginException();
    final pinLoginResponse = await _apiService.userLoginPin(
      UserLoginPinReq(email: email, deviceId: deviceId, pin: _pin),
    );
    if(pinLoginResponse is UserLoginPinResError) throw AuthLoginException();
  }
}
