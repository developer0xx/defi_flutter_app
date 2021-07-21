import 'package:sapiency_app/model/api/signup/available/req/signup_available_req.dart';
import 'package:sapiency_app/model/api/signup/available/res/signup_available_res.dart';
import 'package:sapiency_app/model/api/user/update/req/user_update_req.dart';
import 'package:sapiency_app/model/user/input/user_input.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/model/user/user.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/user/exception/obtain_current/user_obtain_current_exception.dart';
import 'package:sapiency_app/service/user/exception/obtain_with_active_crowdsales/user_obtain_with_active_crowdsales_exception.dart';
import 'package:sapiency_app/service/user/exception/update/user_update_exception.dart';

class UserService {
  final ApiService _apiService;

  const UserService(this._apiService);

  // TODO: replace with proper API endpoint
  Future<bool> doesUserExist({required String nicknameOrEmail}) async {
    final responses = await Future.wait([
      _apiService.signupAvailable(SignupAvailableReqEmail(email: nicknameOrEmail)),
      _apiService.signupAvailable(SignupAvailableReqNickname(nickname: nicknameOrEmail)),
    ]);
    return responses.any((it) => it.body! is SignupAvailableResError);
  }

  Future<User> obtainCurrent() async {
    final response = await _apiService.getUser();
    return response.body!.when(
      ok: (user) => user,
      error: () => throw UserObtainCurrentException(),
    );
  }

  Future<User> update(UserInput user) async {
    final response = await _apiService.updateUser(UserUpdateReq(user: user));
    return response.body!.when(
      ok: (user) => user,
      error: () => throw UserUpdateException(),
    );
  }

  Future<List<PublicUserInfluencer>> obtainWithActiveCrowdsales() async {
    final response = await _apiService.getUsersWithActiveCrowdsales();
    return response.body!.when(
      ok: (users) => users,
      error: () => throw UserObtainWithActiveCrowdsalesException(),
    );
  }
}
