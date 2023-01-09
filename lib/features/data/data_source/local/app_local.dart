import 'dart:convert';

import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/preferences/app_prefs.dart';
import '../../model/response/auth/app_response.dart';

abstract class AuthLocalDataSource{
  Future<AuthenticationResponse> authentication();
  Future<bool> cashUserAuthentication(AuthenticationResponse authentication);
  bool isUserLoggedIn();
  Future<void> logout() ;


}
class AuthLocalDataSourceImpl implements AuthLocalDataSource{

  final AppSettingPreferences appSettingPreferences;
  AuthLocalDataSourceImpl(this.appSettingPreferences);
  @override
  Future<AuthenticationResponse> authentication() async{
    return  await appSettingPreferences.getUserData();
  }
  @override
  Future<void> logout() {
    return appSettingPreferences.logout();
  }
  @override
  Future<bool> cashUserAuthentication(AuthenticationResponse authenticationResponse )async {

    return await appSettingPreferences.setUserAuthentication(jsonEncode(authenticationResponse.toJson()));
  }
  @override
  bool isUserLoggedIn(){
   return  appSettingPreferences.getAppUserISLoggedIn();
  }


}