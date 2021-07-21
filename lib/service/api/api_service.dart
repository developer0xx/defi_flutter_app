import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:sapiency_app/model/api/influencer/setup/req/setup_influencer_req.dart';
import 'package:sapiency_app/model/api/influencer/setup/res/setup_influencer_res.dart';
import 'package:sapiency_app/model/api/payment/req/payment_req.dart';
import 'package:sapiency_app/model/api/payment/res/payment_res.dart';
import 'package:sapiency_app/model/api/signup/available/req/signup_available_req.dart';
import 'package:sapiency_app/model/api/signup/available/res/signup_available_res.dart';
import 'package:sapiency_app/model/api/signup/step/confirm/req/signup_step_confirm_req.dart';
import 'package:sapiency_app/model/api/signup/step/confirm/res/signup_step_confirm_res.dart';
import 'package:sapiency_app/model/api/signup/step/create/req/signup_step_create_req.dart';
import 'package:sapiency_app/model/api/signup/step/create/res/signup_step_create_res.dart';
import 'package:sapiency_app/model/api/user/get/res/get_user_res.dart';
import 'package:sapiency_app/model/api/user/login/email/req/user_login_email_req.dart';
import 'package:sapiency_app/model/api/user/login/email/res/user_login_email_res.dart';
import 'package:sapiency_app/model/api/user/login/pin/req/user_login_pin_req.dart';
import 'package:sapiency_app/model/api/user/login/pin/res/user_login_pin_res.dart';
import 'package:sapiency_app/model/api/user/login/pin/set/req/user_login_pin_set_req.dart';
import 'package:sapiency_app/model/api/user/login/pin/set/res/user_login_pin_set_res.dart';
import 'package:sapiency_app/model/api/user/password_recovery/confirm/req/user_password_recovery_confirm_req.dart';
import 'package:sapiency_app/model/api/user/password_recovery/confirm/res/user_password_recovery_confirm_res.dart';
import 'package:sapiency_app/model/api/user/password_recovery/req/user_password_recovery_req.dart';
import 'package:sapiency_app/model/api/user/password_recovery/res/user_password_recovery_res.dart';
import 'package:sapiency_app/model/api/user/signup/req/user_signup_req.dart';
import 'package:sapiency_app/model/api/user/signup/res/user_signup_res.dart';
import 'package:sapiency_app/model/api/user/update/req/user_update_req.dart';
import 'package:sapiency_app/model/api/user/update/res/user_update_res.dart';
import 'package:sapiency_app/model/api/user/with_active_crowdsales/res/get_users_with_active_crowdsales_res.dart';
import 'package:sapiency_app/model/api/version/req/check_version_req.dart';
import 'package:sapiency_app/model/api/version/res/check_version_res.dart';
import 'package:sapiency_app/model/api/wallet/send/sapiency/req/wallet_send_sapiency_req.dart';
import 'package:sapiency_app/model/api/wallet/send/sapiency/res/wallet_send_sapiency_res.dart';
import 'package:sapiency_app/service/api/client/api_client_service.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create(ApiClientService clientService) => _$ApiService(clientService.createClient());

  //region Authorization
  @Post(path: '/signup/available')
  Future<Response<SignupAvailableRes>> signupAvailable(@Body() SignupAvailableReq req);

  @Put(path: '/user/signup')
  Future<Response<UserSignupRes>> userSignup(@Body() UserSignupReq req);

  @Put(path: '/signup/step/{stepId}')
  Future<Response<SignupStepCreateRes>> signupStepCreate(@Path() String stepId, @Body() SignupStepCreateReq req);

  @Post(path: '/signup/step/{stepId}')
  Future<Response<SignupStepConfirmRes>> signupStepConfirm(@Path() String stepId, @Body() SignupStepConfirmReq req);

  @Post(path: '/user/login')
  Future<Response<UserLoginEmailRes>> userLoginEmail(@Body() UserLoginEmailReq req);

  @Post(path: '/user/login')
  Future<Response<UserLoginPinRes>> userLoginPin(@Body() UserLoginPinReq req);

  @Put(path: '/user/login')
  Future<Response<UserLoginPinSetRes>> userLoginPinSet(@Body() UserLoginPinSetReq req);

  @Put(path: '/user/password-recovery')
  Future<Response<UserPasswordRecoveryRes>> userPasswordRecovery(@Body() UserPasswordRecoveryReq req);

  @Post(path: '/user/password-recovery')
  Future<Response<UserPasswordRecoveryConfirmRes>> userPasswordRecoveryConfirm(
    @Body() UserPasswordRecoveryConfirmReq req,
  );

  //endregion

  //region User
  @Get(path: '/user')
  Future<Response<GetUserRes>> getUser();

  @Post(path: '/user')
  Future<Response<UserUpdateRes>> updateUser(@Body() UserUpdateReq req);

  @Get(path: '/user/withActiveCrowdsales')
  Future<Response<GetUsersWithActiveCrowdsalesRes>> getUsersWithActiveCrowdsales();

  @Post(path: '/checkVersion')
  Future<Response<CheckVersionRes>> checkVersion(@Body() CheckVersionReq req);

  //endregion

  //region Influencer
  @Put(path: '/influencer')
  Future<Response<SetupInfluencerRes>> setupInfluencer(@Body() SetupInfluencerReq req);

  //endregion

  //region Wallet
  @Post(path: '/wallet/send/sapiency')
  Future<Response<WalletSendSapiencyRes>> walletSendSapiency(@Body() WalletSendSapiencyReq req);

  //endregion

  //region Payment
  @Post(path: '/payment')
  Future<Response<PaymentRes>> payment(@Body() PaymentReq req);
//endregion
}
