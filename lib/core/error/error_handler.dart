
import 'package:hesham/core/resources/app_api_codes.dart';
import 'package:hesham/core/resources/app_api_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/extension/extension.dart';

import '../../features/domain/entities/failure.dart';
import '../enum/enums.dart';
import '../resources/app_constant.dart';
import 'package:dio/dio.dart';


class UrlLauncherException implements Exception {
  late Failure failure;
  UrlLauncherException.handleUrlLancherError(dynamic error){
    if(error is DataSourceLaunchUrl)
    {
      failure = _handleLaunchUrlError(error);
    }
    else if(error is FormatException)
    {
      failure=DataSourceLaunchUrl.inValidUrl.getFailure();
    }
    else
    {
      failure = DataSourceLaunchUrl.unKnownLauncherError.getFailure();
    }
  }

  Failure _handleLaunchUrlError(DataSourceLaunchUrl dataSourceLaunchUrl)
  {
    switch(dataSourceLaunchUrl)
    {
      case DataSourceLaunchUrl.cantNotOpen:
        return DataSourceLaunchUrl.cantNotOpen.getFailure();
      case DataSourceLaunchUrl.inValidUrl:
        return DataSourceLaunchUrl.inValidUrl.getFailure();
      case DataSourceLaunchUrl.systemError:
        return DataSourceLaunchUrl.systemError.getFailure();
      default:
        return DataSourceLaunchUrl.unKnownLauncherError.getFailure();
    }
  }


}
class BatteryException implements Exception {
  late Failure failure;
  BatteryException.handlePermissionError(dynamic error){
    if(error is DataSourceBatteryState)
    {
      failure = _handleBatteryError(error);
    }
    else
    {
      failure = DataSourceTimer.unknownError.getFailure();
    }
  }

  Failure _handleBatteryError(DataSourceBatteryState dataSourceBatteryState)
  {
    switch(dataSourceBatteryState)
    {
      case DataSourceBatteryState.errorInfo:
        return DataSourceBatteryState.errorInfo.getFailure();
      default:
        return DataSourceBatteryState.unknownError.getFailure();
    }
  }


}
class TimerException implements Exception {
  late Failure failure;
  TimerException.handlePermissionError(dynamic error){
    if(error is DataSourceTimer)
    {
      failure = _handleTimerError(error);
    }
    else
    {
      failure = DataSourceTimer.unknownError.getFailure();
    }
  }

  Failure _handleTimerError(DataSourceTimer dataSourceTimer)
  {
    switch(dataSourceTimer)
    {
      case DataSourceTimer.timerCancelError:
        return DataSourceTimer.timerCancelError.getFailure();
      case DataSourceTimer.errorTimer:
        return DataSourceTimer.errorTimer.getFailure();
      case DataSourceTimer.isInactive:
        return DataSourceTimer.isInactive.getFailure();
      case DataSourceTimer.isActive:
        return DataSourceTimer.isActive.getFailure();
      default:
        return DataSourceTimer.unknownError.getFailure();
    }
  }


}
class NetworkException implements Exception {
  late Failure failure;
  NetworkException.handleNetworkError(dynamic error){

    if(error is DioError)
    {
      failure= _handleNetworkDioFailure(error);
    }
    else
    {
      failure= DataSourceNetworkError.unknownError.getFailure();
    }

  }

  Failure _handleNetworkDioFailure(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSourceNetworkError.connectTimeOut.getFailure();
      case DioErrorType.sendTimeout:
        return DataSourceNetworkError.sendTimeOut.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSourceNetworkError.recieveTimeOut.getFailure();
      case DioErrorType.response:
        if (error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
          if(error.response?.statusCode==401)
            {
              return AppConstants.unAuthenticatedFailure;
            }

          return Failure(error.response?.statusCode ?? AppConstants.defaultEmptyInteger, error.response?.statusMessage ?? AppConstants.defaultEmptyString);
        } else {
          return DataSourceNetworkError.unknownError.getFailure();
        }
      case DioErrorType.cancel:
        return DataSourceNetworkError.cancel.getFailure();
      case DioErrorType.other:
        return DataSourceNetworkError.unknownError.getFailure();
    }
  }










}
class CashedException implements Exception {
  late Failure failure;
  CashedException.handleCashedError(dynamic error){


    failure= DataSourceNetworkError.cashError.getFailure();


  }

  Failure _handleNetworkDioFailure(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSourceNetworkError.connectTimeOut.getFailure();
      case DioErrorType.sendTimeout:
        return DataSourceNetworkError.sendTimeOut.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSourceNetworkError.recieveTimeOut.getFailure();
      case DioErrorType.response:
        if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
          return Failure(
              error.response?.statusCode ??
                  AppConstants.defaultEmptyInteger,
              error.response?.statusMessage ??
                  AppConstants.defaultEmptyString);
        } else {
          return DataSourceNetworkError.unknownError.getFailure();
        }
      case DioErrorType.cancel:
        return DataSourceNetworkError.cancel.getFailure();
      case DioErrorType.other:
        return DataSourceNetworkError.unknownError.getFailure();
    }
  }










}
class PermissionException implements Exception {
  late Failure failure;
  PermissionException.handlePermissionError(dynamic error){

    if(error is DataSourcePermission)
    {
      failure = _handlePermissionError(error);
    }
    else
    {
      failure = DataSourcePermission.unknownPermissionError.getFailure();
    }





  }

  Failure _handlePermissionError(DataSourcePermission dataSourcePermissionError)
  {
    switch(dataSourcePermissionError)
    {
      case DataSourcePermission.permissionDenied:
        return DataSourcePermission.permissionDenied.getFailure();
      case DataSourcePermission.permissionPermanentlyDenied:
        return DataSourcePermission.permissionPermanentlyDenied.getFailure();
      case DataSourcePermission.permissionRestricted:
        return DataSourcePermission.permissionRestricted.getFailure();
      case DataSourcePermission.checkPermissionError:
        return DataSourcePermission.checkPermissionError.getFailure();
      case DataSourcePermission.noImageSelected:
        return DataSourcePermission.noImageSelected.getFailure();
      default:
        return DataSourcePermission.unknownPermissionError.getFailure();
    }
  }










}


class ErrorMessage implements Exception{
  late Failure failure;
  ErrorMessage.getErrorAuth(String? codeError)
  {

    failure=_getErrorAuth(codeError);



  }
  Failure _getErrorAuth(String? codeError) {

    switch (codeError)
    {
      case ErrorCode.unknownError://000000
        return const Failure(ResponseCode.unknownError,ResponseMessage.unknownError,);
      case ErrorCode.authAccountBlocked://100001
        return const Failure(ResponseCode.authAccountBlocked,ResponseMessage.authAccountBlocked,);
      case ErrorCode.authAccountDeleted://100002
        return const Failure(ResponseCode.authAccountDeleted,ResponseMessage.authAccountDeleted,);
      case ErrorCode.authVerificationCodeNotSend://100003
        return const Failure(ResponseCode.authVerificationCodeNotSend,ResponseMessage.authVerificationCodeNotSend,);
      case ErrorCode.authDataInValidData://100004
        return const Failure(ResponseCode.authLoginInvalidData,ResponseMessage.authLoginInvalidData,);
      case ErrorCode.addMaintainErrorOccurred://100005
        return const Failure(ResponseCode.maintenanceNotAdded,ResponseMessage.maintenanceNotAdded,);
      case ErrorCode.authCreationAccountAlreadyExist://100006
        return const Failure(ResponseCode.authThisDataExistsRegister,ResponseMessage.authThisDataExists,);
      case ErrorCode.authErrorOccurredInRegister://100007
        return const Failure(ResponseCode.authRegisterError,ResponseMessage.authRegisterError,);
      case ErrorCode.authAccountNotExist://100008
        return const Failure(ResponseCode.notExistAccount,ResponseMessage.authAccountDataErrorNotFound,);
      case ErrorCode.passwordNotUpdated://100009
        return const Failure(ResponseCode.missMatchPassword,ResponseMessage.missMatchPassword,);
      case ErrorCode.tripNotExists://100010
        return const Failure(ResponseCode.tripNotExist,ResponseMessage.tripNotExist,);
      case ErrorCode.NoBalanceEnough://100011
        return const Failure(ResponseCode.notEnoughMoney,ResponseMessage.notEnoughMoney,);
      case ErrorCode.dataTransferInvalid://100012
        return const Failure(ResponseCode.transferDataNotCorrect,ResponseMessage.transferDataNotCorrect,);
      case ErrorCode.dataTransferInvalid14://100012
        return const Failure(ResponseCode.dataNotCorrect14,ResponseMessage.dataNotCorrect14,);
        case ErrorCode.dataTransferInvalid15://100012
        return const Failure(ResponseCode.dataNotCorrect15,ResponseMessage.dataNotCorrect15,);
        case ErrorCode.dataTransferInvalid16://100012
        return const Failure(ResponseCode.dataNotCorrect16,ResponseMessage.dataNotCorrect16,);
        case ErrorCode.dataTransferInvalid17://100012
        return const Failure(ResponseCode.dataNotCorrect17,ResponseMessage.dataNotCorrect17,);
      default:
        return const Failure(ResponseCode.unknownError,ResponseMessage.unknownError,);


    }
  }

}



