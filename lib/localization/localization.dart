import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localization.g.dart';

@SheetLocalization("1h6J8VZNuA1tk_ifEFZzUvZEra2Ga3kZ-07oZRa51AHM", "0", 97)
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizationsData> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => localizedLabels.containsKey(locale);

  @override
  Future<AppLocalizationsData> load(Locale locale) => SynchronousFuture<AppLocalizationsData>(localizedLabels[locale]!);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
