// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enum/enums.dart';
import '../preferences/app_prefs.dart';


abstract class LangaugeManager
{
  Locale getLangaugeApp();

  Future<void> setLangaugeApp(LangaugeCode langaugeCode);

}
class LangaugeManagerImpl extends LangaugeManager {

  final AppSettingPreferences _appSettingPreferences;

  LangaugeManagerImpl(this._appSettingPreferences);


  @override
  Locale getLangaugeApp()=>_getLangaugeType().getLocalValue();

  @override
  Future<void> setLangaugeApp(LangaugeCode langaugeCode) async=> await _appSettingPreferences.setAppLanguage(langaugeCode.getLangaugeCode());

  LangaugeCode _getLangaugeType() =>  _appSettingPreferences.getAppLanguage().getLangaugeCode();


}
