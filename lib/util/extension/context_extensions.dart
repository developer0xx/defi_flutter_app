import 'package:flutter/material.dart';
import 'package:sapiency_app/localization/localization.dart';

extension ContextExtensions on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
  AppLocalizationsData get strings => Localizations.of<AppLocalizationsData>(this, AppLocalizationsData)!;
  T? routeArgs<T>() => ModalRoute.of(this)!.settings.arguments as T;
}
