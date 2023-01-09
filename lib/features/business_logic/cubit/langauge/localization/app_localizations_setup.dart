
import 'dart:ui';

import 'package:hesham/core/resources/app_constant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';


class AppLocalizationsSetup {
static const Iterable<Locale> supportedLocales= AppConstants.supportedLocales;
static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates=[
  AppLocalizationsImpl.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate
];
static Locale localeResolutionCallBack(Locale? locale,Iterable<Locale>? supportedLocales){
  for(Locale supportedLocale in supportedLocales!)
    {
      if(supportedLocale.languageCode==locale!.languageCode&&supportedLocale.countryCode==locale.countryCode)
        {
          return supportedLocale;
        }
    }
  return supportedLocales.first;
}

}
