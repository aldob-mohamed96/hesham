

import 'dart:convert';
import 'dart:developer';


import 'package:hesham/features/domain/entities/logout.dart';
import 'package:flutter/cupertino.dart';

import '../../features/data/model/response/auth/app_response.dart';
import '../resources/app_constant.dart';
import '../extension/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';



abstract class AppSettingPreferences {

  //setting app local data

  Future<bool> setAppLanguage(String value);
  Future<bool> setAppTheme(String value);
  Future<bool> setAppOnBoardingISViewed(bool value);
  String getAppLanguage();
  String getAppTheme();
  bool getAppOnBoardingIsViewed();

  //auth app local data

  bool getAppUserISLoggedIn();
  Future<AuthenticationResponse> getUserData();

  Future<bool> setUserAuthentication(String value);
  Future<bool> setAppUserISLoggedIn(bool value);
  Future<void> logout();

  //order operation data



}


class AppSettingPreferencesImpl implements AppSettingPreferences {

  final SharedPreferences appPref;

  AppSettingPreferencesImpl(this.appPref);

///////////////////////////////////////  setting app lang and theme  view onBoarding /////////////////////////////////////////////////////
  @override
  String getAppLanguage() =>
      appPref.getString(AppConstants.appLanguagePrefsKey).orLengthZero(
          empty: AppConstants.defaultLanguageAppCode);

  @override
  String getAppTheme() =>
      appPref.getString(AppConstants.appThemeModePrefsKey).orLengthZero(
          empty: AppConstants.defaultThemeModeApp);

  @override
  bool getAppOnBoardingIsViewed() =>
      appPref.getBool(AppConstants.appOnBoardingIsViewedPrefsKey).orBoolInit();

  @override
  Future<bool> setAppLanguage(String value) async =>
      await appPref.setString(AppConstants.appLanguagePrefsKey, value);

  @override
  Future<bool> setAppOnBoardingISViewed(bool value) async =>
      await appPref.setBool(AppConstants.appOnBoardingIsViewedPrefsKey, value);

  @override
  Future<bool> setAppTheme(String value) async =>
      await appPref.setString(AppConstants.appThemeModePrefsKey, value);


  //////////////////////////////////////  auth operation //////////////////////////////////


  @override
  Future<bool> setAppUserISLoggedIn(bool value) async =>
      await appPref.setBool(AppConstants.appUserIsLoggedInPrefsKey, value);

  @override
  bool getAppUserISLoggedIn() =>
      appPref.getBool(AppConstants.appUserIsLoggedInPrefsKey).orBoolInit();

  @override
  Future<bool> setUserAuthentication(String value) async {
    await setAppUserISLoggedIn(true);
    return await appPref.setString(
        AppConstants.appCashedAuthenticationResponse, value);
  }

  @override
  Future<AuthenticationResponse> getUserData() async {
    final authUser = appPref.getString(
        AppConstants.appCashedAuthenticationResponse);
    return AuthenticationResponse.fromJson(
        json.decode(authUser!) as Map<String, dynamic>);
  }


  @override
  Future<void> logout() async {
    final lang=getAppLanguage();
    final theme= getAppTheme();
    await appPref.clear();
    await setAppLanguage(lang);
    await setAppTheme(theme);
    await setAppOnBoardingISViewed(true);

  }




}
