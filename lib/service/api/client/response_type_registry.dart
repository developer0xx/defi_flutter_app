import 'package:sapiency_app/model/api/influencer/setup/res/setup_influencer_res.dart';
import 'package:sapiency_app/model/api/payment/res/payment_res.dart';
import 'package:sapiency_app/model/api/signup/available/res/signup_available_res.dart';
import 'package:sapiency_app/model/api/signup/step/confirm/res/signup_step_confirm_res.dart';
import 'package:sapiency_app/model/api/signup/step/create/res/signup_step_create_res.dart';
import 'package:sapiency_app/model/api/user/get/res/get_user_res.dart';
import 'package:sapiency_app/model/api/user/login/email/res/user_login_email_res.dart';
import 'package:sapiency_app/model/api/user/login/pin/res/user_login_pin_res.dart';
import 'package:sapiency_app/model/api/user/login/pin/set/res/user_login_pin_set_res.dart';
import 'package:sapiency_app/model/api/user/password_recovery/confirm/res/user_password_recovery_confirm_res.dart';
import 'package:sapiency_app/model/api/user/password_recovery/res/user_password_recovery_res.dart';
import 'package:sapiency_app/model/api/user/signup/res/user_signup_res.dart';
import 'package:sapiency_app/model/api/user/update/res/user_update_res.dart';
import 'package:sapiency_app/model/api/user/with_active_crowdsales/res/get_users_with_active_crowdsales_res.dart';
import 'package:sapiency_app/model/api/version/res/check_version_res.dart';
import 'package:sapiency_app/model/api/wallet/send/sapiency/res/wallet_send_sapiency_res.dart';

final responseTypeRegistry = <Type, Function(dynamic json)>{
  //region Auth
  SignupAvailableRes: (json) => SignupAvailableRes.fromJson(json),
  SignupStepConfirmRes: (json) => SignupStepConfirmRes.fromJson(json),
  SignupStepCreateRes: (json) => SignupStepCreateRes.fromJson(json),
  UserLoginEmailRes: (json) => UserLoginEmailRes.fromJson(json),
  UserLoginPinRes: (json) => UserLoginPinRes.fromJson(json),
  UserLoginPinSetRes: (json) => UserLoginPinSetRes.fromJson(json),
  UserSignupRes: (json) => UserSignupRes.fromJson(json),
  UserPasswordRecoveryRes: (json) => UserPasswordRecoveryRes.fromJson(json),
  UserPasswordRecoveryConfirmRes: (json) => UserPasswordRecoveryConfirmRes.fromJson(json),
  //endregion

  //region User
  GetUserRes: (json) => GetUserRes.fromJson(json),
  UserUpdateRes: (json) => UserUpdateRes.fromJson(json),
  GetUsersWithActiveCrowdsalesRes: (json) => GetUsersWithActiveCrowdsalesRes.fromJson(json),
  //endregion

  //region Influencer
  SetupInfluencerRes: (json) => SetupInfluencerRes.fromJson(json),
  //endregion

  //region Payment
  PaymentRes: (json) => PaymentRes.fromJson(json),
  //endregion

  //region Wallet
  WalletSendSapiencyRes: (json) => WalletSendSapiencyRes.fromJson(json),
  //endregion

  CheckVersionRes: (json) => CheckVersionRes.fromJson(json),
};