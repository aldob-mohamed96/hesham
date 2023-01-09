import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hesham/core/di/dependency_injection.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/core/resources/langauge_manager.dart';
import 'package:hesham/core/services/app_settiings.dart';
import 'package:flutter/material.dart';


part 'langauge_state.dart';

class LangaugeCubit extends Cubit<LangaugeState> {

  final LangaugeManager langaugeManager;
  LangaugeCubit({required this.langaugeManager}) : super(LangaugeState(AppConstants.defaultLanguageAppCode.getLocalValue()));


  Future<void> getAppLangauge()async
  {
    final locale=langaugeManager.getLangaugeApp();
    emit(LangaugeState(locale));
  }
  Future<void> changeAppLangauge(LangaugeCode langaugeCode)async
  {
    await langaugeManager.setLangaugeApp(langaugeCode);
    instance<AppSettings>().appSetting.copyWith(locale: langaugeCode.getLocalValue());
    emit(LangaugeState(langaugeCode.getLocalValue()));

  }

}

