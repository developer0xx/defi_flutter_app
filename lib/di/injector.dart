import 'package:injector/injector.dart';
import 'package:sapiency_app/config/config.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/api/client/api_client_service.dart';
import 'package:sapiency_app/service/auth/login/auth_login_service.dart';
import 'package:sapiency_app/service/auth/password_recovery/auth_password_recovery_service.dart';
import 'package:sapiency_app/service/auth/signup/auth_signup_service.dart';
import 'package:sapiency_app/service/crowdsale/computed/crowdsale_computed_data_service.dart';
import 'package:sapiency_app/service/device/device_service.dart';
import 'package:sapiency_app/service/influencer/influencer_service.dart';
import 'package:sapiency_app/service/payment/payment_service.dart';
import 'package:sapiency_app/service/storage/shared_preferences_service.dart';
import 'package:sapiency_app/service/storage/storage_service.dart';
import 'package:sapiency_app/service/user/user_service.dart';
import 'package:sapiency_app/service/version/version_service.dart';
import 'package:sapiency_app/service/wallet/wallet_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

Injector setupInjector() {
  final injector = Injector();
  injector
    ..registerSingleton<Config>(() => Config.current)..registerSingleton(() => SharedPreferencesService())
    ..registerSingleton(() => ApiClientService(injector.get(), injector.get()))
    ..registerSingleton<ApiService>(() => ApiService.create(injector.get()))
    ..registerSingleton(() => DeviceService(injector.get()))
    ..registerSingleton(() => AuthSignupService(injector.get()))
    ..registerSingleton(() => AuthLoginService(injector.get(), injector.get(), injector.get()))
    ..registerSingleton(() => AuthPasswordRecoveryService(injector.get()))
    ..registerSingleton(() => UserService(injector.get()))
    ..registerSingleton(() => CrowdsaleComputedDataService())
    ..registerSingleton(() => InfluencerService(injector.get()))
    ..registerSingleton(() => PaymentService(injector.get()))
    ..registerSingleton(() => StorageService())
    ..registerSingleton(() => WalletService(injector.get()))
    ..registerSingleton(() => VersionService(injector.get(), injector.get()));
  return injector;
}

T useInjected<T>() => useProvided<Injector>().get<T>();
