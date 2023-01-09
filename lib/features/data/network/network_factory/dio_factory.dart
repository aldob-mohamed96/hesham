// ignore_for_file: constant_identifier_names


import '../../../../core/resources/app_constant.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioFactory{
  Future<Dio> getDio();


}
class DioFactoryImpl extends DioFactory{


  @override
  Future<Dio> getDio()async{




   Dio dio=Dio();
   Map<String,String>headers={
     NetworkConstant.CONTENT_TYPE:NetworkConstant.APPLICATION_JSON,
     NetworkConstant.ACCEPT:NetworkConstant.APPLICATION_JSON,



   };

   dio.options=BaseOptions(
     baseUrl: kDebugMode?AppConstants.baseUrlsDebug:AppConstants.baseUrls,
     receiveTimeout: NetworkConstant.apiTimeOut,
     sendTimeout: NetworkConstant.apiTimeOut,
     headers: headers,


   );

   //logs in debug mode only for security
    if(!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true
      ));
      }

    return dio;
  }




}