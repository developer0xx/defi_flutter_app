import 'package:equatable/equatable.dart';
import 'package:sapiency_app/util/extension/extensions.dart';

class Config extends Equatable {
  static const String googlePlayUrl = 'https://play.google.com/store/apps/details?id=com.io.sapiency';
  final String apiBaseUrl;
  final String? version = _currentVersion.takeIf((it) => it != '');
  final bool isWalletEnabled;

  Config._({required this.apiBaseUrl, required this.isWalletEnabled});

  @override
  get props => [apiBaseUrl, version];

  static final dev = Config._(apiBaseUrl: 'http://sapiency.softja.eu/api', isWalletEnabled: true);
  static final prod = Config._(apiBaseUrl: 'https://v2.sapiency.app/api', isWalletEnabled: false);
  static final all = {'dev': dev, 'prod': prod};

  static const _currentName = String.fromEnvironment('CONFIG', defaultValue: 'dev');
  static const _currentVersion = String.fromEnvironment('VERSION');
  static final current = all[_currentName]!;
}