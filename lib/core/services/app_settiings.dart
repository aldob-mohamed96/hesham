import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/features/domain/usecases/app_usecase.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../features/domain/entities/setting_app.dart';
import '../preferences/app_prefs.dart';
import '../resources/langauge_manager.dart';
import '../resources/theme_manager.dart';

abstract class AppSettings{
  Future<void> getAppSettings();
  SettingApp get appSetting;
}
class AppSettingImpl extends AppSettings{
  final AuthenticationUseCase authenticationUseCase;
  final ThemeManager themeManager;
  final LangaugeManager langaugeManager;
  final AppSettingPreferences appSettingPreferences;
  late SettingApp _appSettings;
  AppSettingImpl({required this.authenticationUseCase,required this.langaugeManager,required this.themeManager,required this.appSettingPreferences});
  @override
  Future<void> getAppSettings() async{
    final themeMode=themeManager.getThemeMode();
    final locale=langaugeManager.getLangaugeApp();
    final route=await _getStateUser();
    _appSettings= SettingApp(route: route,themeMode:themeMode,locale:locale);

  }

  Future<String> _getStateUser()async
  {
   try {
     final result=await authenticationUseCase.isLoggedIn();
     result.fold((unAuthenticated) { return _getIsViewedOrNotState();}, (authenticated) {return Routes.maintainAppRoot;});
     return _getIsViewedOrNotState();
   }
   catch(error)
   {
     return _getIsViewedOrNotState();
   }

  }

  String _getIsViewedOrNotState()
  {
   return  _isViewedOnBoarding()?Routes.loginRoot:Routes.onBoardingRoot;
  }
  bool _isViewedOnBoarding()
  {
    return appSettingPreferences.getAppOnBoardingIsViewed();
  }

  @override
  SettingApp get appSetting => _appSettings;


}