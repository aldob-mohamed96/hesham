import 'dart:convert';
import 'dart:ui';

import 'package:hesham/core/helper/helper_function.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/resources/assets_manager.dart';
import 'app_localization_delegate.dart';
 abstract class AppLocalizations{
  Future<void> load();
  String? translate(String key);
  String get getCurrentLocale;
}
class AppLocalizationsImpl implements AppLocalizations {
  final Locale locale;
  late Map<String,String> _localizedStrings;
  AppLocalizationsImpl(this.locale);


  static AppLocalizationsImpl? of(BuildContext context) => Localizations.of<AppLocalizationsImpl>(context, AppLocalizations);
  static const LocalizationsDelegate<AppLocalizations> delegate=AppLocalizationsDelegate();
  String get jsonFileContent=>assetTranslationsJson+locale.languageCode+'.json';

  @override
  Future<void> load() async{
     final result=await HelperFunctionImpl().getJsonFile(jsonFileContent);
     result.fold((l) => l, (r) => _localizedStrings=r);

  }


  @override
  String translate(String key)=>_localizedStrings[key]??key;

  @override
  String get getCurrentLocale => locale.languageCode;


}
