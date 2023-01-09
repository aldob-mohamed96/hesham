
import 'package:flutter/material.dart' show Locale,LocalizationsDelegate;

import '../../../../../core/resources/app_constant.dart';
import 'app_localizations.dart';
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>[AppConstants.englishLanguageCode,AppConstants.arabicLanguageCode]
      .contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale)async {
    AppLocalizations appLocalizations=AppLocalizationsImpl(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>false;

}