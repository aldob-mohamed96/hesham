

import 'dart:developer';
import 'dart:io';

import 'package:hesham/core/resources/app_constant.dart';
 import 'package:hesham/features/business_logic/bloc/auth/auth/authentication_bloc.dart';
import 'package:hesham/features/data/model/response/note/note_response.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/firbase.dart';
import '../../model/response/auth/app_response.dart';
import '../../network/api/auth/app_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../network/requests_entity/request_entity.dart';


abstract class AuthRemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<HomeSubjectResponse> getHome();
  Future<LogoutAuthResponse> logout();
  Future<SuccessOperationResponse> attendance(LessonRequest lessonRequest);
  Future<SuccessOperationResponse> sheet(SheetRequest sheetRequest);
  Future<SuccessOperationResponse> addContact(AddContactRequest addContactRequest);
  Future<ContactResponse> contacts(LessonRequest sheetRequest);
  Future<NoteOrdersPaginationResponse> getNote(LessonRequest sheetRequest);

 }
class AuthRemoteDataSourceImp  implements AuthRemoteDataSource{
  final AppServiceApiClient _appServiceApiClient;
  AuthRemoteDataSourceImp(this._appServiceApiClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    String id=await _getId()??"";
    String token=await instance<FirebaseData>().getToken();
    log(token);
   return await _appServiceApiClient.login(loginRequest.phone,loginRequest.password,token,id);
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }


  @override
  Future<HomeSubjectResponse> getHome() async{
   String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
    return await _appServiceApiClient.getHomeData(token);
  }

  @override
  Future<SuccessOperationResponse> attendance(LessonRequest lessonRequest)async {
    String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
    String userId=instance<AuthenticationBloc>().user.id.toString() ;
    return await _appServiceApiClient.attendance(token,userId,lessonRequest.id.toString());
  }

  @override
  Future<SuccessOperationResponse> sheet(SheetRequest sheetRequest) async{
    String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
    String userId=instance<AuthenticationBloc>().user.id.toString();
    return await _appServiceApiClient.uploadSheet(token,userId,sheetRequest.id.toString(),sheetRequest.file);

  }

  @override
  Future<LogoutAuthResponse> logout() async{

    String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
    return await _appServiceApiClient.logout(token);


  }

  @override
  Future<SuccessOperationResponse> addContact(AddContactRequest addContactRequest) async{

    String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
    String userId=instance<AuthenticationBloc>().user.id.toString();
    return await _appServiceApiClient.addChat(token,userId,addContactRequest.message);

  }

  @override
  Future<ContactResponse> contacts(LessonRequest sheetRequest) async{


      String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
      String userId=instance<AuthenticationBloc>().user.id.toString();
      return await _appServiceApiClient.getContact(token,sheetRequest.id,userId,);
  }

  @override
  Future<NoteOrdersPaginationResponse> getNote(LessonRequest sheetRequest)async {

    String token= "Bearer "+instance<AuthenticationBloc>().user.rememberToken;
    String userId=instance<AuthenticationBloc>().user.id.toString();
    return await _appServiceApiClient.getNote(token,sheetRequest.id,userId,);
  }



}