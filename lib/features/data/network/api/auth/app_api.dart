

import 'dart:io';
import 'package:hesham/features/data/model/response/note/note_response.dart';

import '../../../../../core/resources/app_constant.dart';
import '../../../model/response/auth/app_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';
import '../../requests_entity/request_entity.dart';
part 'app_api.g.dart';

typedef RequestBody=Map<String,dynamic>;
@RestApi(baseUrl: kDebugMode?AppConstants.baseUrlsDebug :AppConstants.baseUrls)
abstract class AppServiceApiClient{
  factory AppServiceApiClient(Dio dio,{String baseUrl})=_AppServiceApiClient;
  @POST(NetworkConstant.loginUrl)
  Future<AuthenticationResponse> login(@Field('username') String username,@Field('password') String password,@Field('notification_token') String token,@Field('mac_address') String macAddress);
  @POST(NetworkConstant.homeUrl)
  Future<HomeSubjectResponse> getHomeData(@Header(NetworkConstant.AUTHORIZATION) String authToken);
  @POST(NetworkConstant.logoutUrl)
  Future<LogoutAuthResponse> logout(@Header(NetworkConstant.AUTHORIZATION) String authToken);
  @POST(NetworkConstant.attendance)
  Future<SuccessOperationResponse> attendance(@Header(NetworkConstant.AUTHORIZATION) String authToken,@Field('user_id') String userId,@Field('lesson_id') String lessonId);
  @POST(NetworkConstant.sheet)
  @MultiPart()
  Future<SuccessOperationResponse> uploadSheet(@Header(NetworkConstant.AUTHORIZATION) String authToken,@Part() String user_id,@Part() String lesson_id ,@Part() File file);
  @POST(NetworkConstant.contacts+"?page={page}")
  Future<ContactResponse> getContact(@Header(NetworkConstant.AUTHORIZATION) String authToken,@Path() int page,@Field('user_id') String userId,);


  @POST(NetworkConstant.addContacts)
  Future<SuccessOperationResponse> addChat(@Header(NetworkConstant.AUTHORIZATION) String authToken,@Field('user_id') String userId,@Field('message') String message);

  @POST(NetworkConstant.notes+"?page={page}")
  Future<NoteOrdersPaginationResponse> getNote(@Header(NetworkConstant.AUTHORIZATION) String authToken,@Path() int page,@Field('user_id') String userId,);

}