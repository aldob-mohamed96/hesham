import 'package:hesham/core/resources/langauge_manager.dart';
import 'package:flutter/material.dart';

import '../../features/domain/entities/failure.dart';
import '../enum/enums.dart';

import '../resources/app_api_codes.dart';
import '../resources/app_api_messages.dart';
import '../resources/app_constant.dart';

extension NonNullString on String? {
  String orEmpty({String empty = AppConstants.defaultEmptyString}) {
    return (this == null) ? empty : this!;
  }

  String orEmptyPaginationJson() {

    return (this == null||this!.isEmpty)? AppConstants.defaultEmptyJsonPagination:this!;
  }

  String orEmptyListJson() {
    return (this == null||this!.isEmpty)? AppConstants.defaultEmptyJsonList:this!;

  }String orEmptyJsonHome() {
    return (this == null||this!.isEmpty)? AppConstants.defaultEmptyJsonHome:this!;

  }
}
extension NonLengthString on String? {
  String orLengthZero({String empty = AppConstants.defaultEmptyString}) {
    return this == null ? empty : this!;
  }
}


extension NonNullInteger on int? {
  int orZeroInt() {
    return (this == null) ? AppConstants.defaultEmptyInteger : this!;
  }
}

extension NonNullDobule on double? {
  double orZeroDouble() {
    return (this == null) ? AppConstants.defaultEmptyDouble : this!;
  }
}

extension NonNullBool on bool? {
  bool orBoolInit() {
    return this == null ? AppConstants.defaultEmptyBool : this!;
  }
}

extension ConvertDoubleTwoDigit on double? {
  double doubleTwoDigit() {
    return (this == null)
        ? AppConstants.defaultEmptyDouble
        : (this?.toStringAsPrecision(2) as double);
  }
}



extension NonNullList on List<String>? {
  List<String> orEmptyList() {
    return (this == null) ? AppConstants.defaultEmptyListString : this!;
  }
}

extension MediaQueryValue on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}
extension ImageExtendion on String?
{
  bool isImage()
  {
    if(this!.endsWith("."+imageExtension.jfif.toString()))
    {
    return true;
    }
    else if(this!.endsWith("."+imageExtension.png.toString()))
     {
       return true;
     }
    else if(this!.endsWith("."+imageExtension.jpeg.toString()))
     {
       return true;
     }
    else if(this!.endsWith("."+imageExtension.jpg.toString()))
     {
       return true;
     }
    else if(this!.endsWith("."+imageExtension.pjpeg.toString()))
     {
       return true;
     }
    else if(this!.endsWith("."+imageExtension.pjp.toString()))
     {
       return true;
     }
    else
      {
        return false;
      }

  }

  AccountState getAccountState()
  {
    switch(this)
    {
      case "pending":
        return AccountState.pending;
      case "waiting":
        return AccountState.pending;
      case "active":
        return AccountState.active;
      case "deleted":
        return AccountState.deleted;
      case "blocked":
      default:
        return AccountState.blocked;
    }
  }

}
extension InputFiledError on DataSourceValidationInput?
{
  String getErrorInput() {
    switch (this) {
    case  DataSourceValidationInput.empty:
     return AppConstants.emptyInput;
    case  DataSourceValidationInput.usernameStyle:
     return AppConstants.usernameStyleInput;
     case  DataSourceValidationInput.shortPassword:
     return AppConstants.shortPasswordInput;
     case  DataSourceValidationInput.notIdenticalPassword:
     return AppConstants.notIdenticalPasswordInput;
     case  DataSourceValidationInput.weakPassword:
     return AppConstants.weakPasswordInput;
     case  DataSourceValidationInput.veryLong:
     return AppConstants.veryLongInput;
     case  DataSourceValidationInput.length:
     return AppConstants.lengthInput;
     case  DataSourceValidationInput.maxInputCount:
     return AppConstants.maxInputCountInput;
     case  DataSourceValidationInput.notPhoneStyle:
     return AppConstants.notPhoneStyleInput;
     case  DataSourceValidationInput.notEmail:
     return AppConstants.notEmailInput;
     case  DataSourceValidationInput.notInteger:
     return AppConstants.notIntegerInput;
      case  DataSourceValidationInput.notDouble:
        return AppConstants.notDoubleInput;
      case  DataSourceValidationInput.notBool:
        return AppConstants.notBoolInput;
      case  DataSourceValidationInput.notString:
        return AppConstants.notStringInput;
        case  DataSourceValidationInput.containSpecialChar:
        return AppConstants.containSpecialCharInput;
      case  DataSourceValidationInput.unknown:
        return AppConstants.unknownInput;
      case  DataSourceValidationInput.valid:
        return AppConstants.validInput;
      case  DataSourceValidationInput.inValidFormat:
        return AppConstants.inValidInput;
      default :
        return AppConstants.validInput;
  }
  }
}
extension LangaugeTypeExtension on LangaugeCode {
  String getLangaugeCode() {
    switch (this) {
      case LangaugeCode.ar:
        return AppConstants.arabicLanguageCode;
      case LangaugeCode.en:
        return AppConstants.englishLanguageCode;
      default:
        return AppConstants.defaultLanguageAppCode;
    }
  }

  Locale getLocalValue() {
    switch (this) {
      case LangaugeCode.ar:
        return AppConstants.arabicLocal;
      case LangaugeCode.en:
        return AppConstants.englishLocal;
      default:
        return AppConstants.englishLocal;
    }
  }
}

extension LangaugeExtension on String? {
  LangaugeCode getLangaugeCode() {
    switch (this) {
      case AppConstants.arabicLanguageCode:
        return LangaugeCode.ar;
      case AppConstants.englishLanguageCode:
        return LangaugeCode.en;
      default:
        return LangaugeCode.en;
    }
  }

  Locale getLocalValue() {
    switch (this) {
      case AppConstants.arabicLanguageCode:
        return AppConstants.arabicLocal;
      case AppConstants.englishLanguageCode:
        return AppConstants.englishLocal;
      default:
        return AppConstants.englishLocal;
    }
  }
}

extension DataSourceExtension on DataSourceNetworkError {
  Failure getFailure() {
    switch (this) {
      case DataSourceNetworkError.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSourceNetworkError.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSourceNetworkError.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSourceNetworkError.badContent:
        return Failure(ResponseCode.badContent, ResponseMessage.badContent);
      case DataSourceNetworkError.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSourceNetworkError.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);
      case DataSourceNetworkError.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSourceNetworkError.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case DataSourceNetworkError.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSourceNetworkError.recieveTimeOut:
        return Failure(
            ResponseCode.recieveTimeOut, ResponseMessage.recieveTimeOut);
      case DataSourceNetworkError.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSourceNetworkError.cashError:
        return Failure(ResponseCode.cashError, ResponseMessage.cashError);
      case DataSourceNetworkError.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      default:
        return Failure(ResponseCode.unknownError, ResponseMessage.unknownError);
    }
  }
}



extension DataSourceLocationExtension on DataSourceLocationError {
  Failure getFailure() {
    switch (this) {
      case DataSourceLocationError.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSourceLocationError.locationUnAvailable:
        return Failure(ResponseCode.locationUnAvailable,
            ResponseMessage.locationUnAvailable);
      case DataSourceLocationError.locationPermissionDined:
        return Failure(ResponseCode.locationPermissionDined,
            ResponseMessage.locationPermissionDined);
      case DataSourceLocationError.locationServiceDisabled:
        return Failure(ResponseCode.locationServiceDisabled,
            ResponseMessage.locationServiceDisabled);
      case DataSourceLocationError.locationDetectedTimeOut:
        return Failure(ResponseCode.locationDetectedTimeOut,
            ResponseMessage.locationDetectedTimeOut);
      case DataSourceLocationError.locationUpdateError:
        return Failure(ResponseCode.locationUpdateError,
            ResponseMessage.locationUpdateError);
      case DataSourceLocationError.locationAlreadySubscribed:
        return Failure(ResponseCode.locationAlreadySubscribed,
            ResponseMessage.locationAlreadySubscribed);

      case DataSourceLocationError.locationActivityMissing:
        return Failure(ResponseCode.locationActivityMissing,
            ResponseMessage.locationActivityMissing);
      default:
        return Failure(
          ResponseCode.unknownError,
          ResponseMessage.unknownError,
        );
    }
  }
}

extension DataSourcePermissionErrorExtension on DataSourcePermission {
  Failure getFailure() {
    switch (this) {
      case DataSourcePermission.checkPermissionError:
        return Failure(ResponseCode.permissionCheckError,
            ResponseMessage.permissionCheckError);
      case DataSourcePermission.permissionDenied:
        return Failure(
            ResponseCode.permissionDined, ResponseMessage.permissionDined);
      case DataSourcePermission.permissionPermanentlyDenied:
        return Failure(ResponseCode.permissionPermanentlyDenied,
            ResponseMessage.permissionPermanentlyDenied);
      case DataSourcePermission.permissionRestricted:
        return Failure(ResponseCode.permissionRestricted,
            ResponseMessage.permissionRestricted);
      case DataSourcePermission.noImageSelected:
        return Failure(
            ResponseCode.noImageSelected, ResponseMessage.noImageSelected);
      case DataSourcePermission.unknownPermissionError:
        return Failure(ResponseCode.unknownPermissionError,
            ResponseMessage.unknownPermissionError);
      default:
        return Failure(
          ResponseCode.unknownPermissionError,
          ResponseMessage.unknownPermissionError,
        );
    }
  }
}

extension DataSourceLaunchUrlExtension on DataSourceLaunchUrl {
  Failure getFailure() {
    switch (this) {
      case DataSourceLaunchUrl.cantNotOpen:
        return Failure(ResponseCode.cantNotOpen, ResponseMessage.cantNotOpen);
      case DataSourceLaunchUrl.systemError:
        return Failure(ResponseCode.systemError, ResponseMessage.systemError);
      case DataSourceLaunchUrl.inValidUrl:
        return Failure(ResponseCode.inValidUrl, ResponseMessage.inValidUrl);
      default:
        return Failure(
          ResponseCode.unKnownLauncherError,
          ResponseMessage.unKnownLauncherError,
        );
    }
  }
}

extension DataSourceBatteryStateExtension on DataSourceBatteryState {
  Failure getFailure() {
    switch (this) {
      case DataSourceBatteryState.errorInfo:
        return Failure(
            ResponseCode.batteryInfoError, ResponseMessage.batteryInfoError);
      default:
        return Failure(
          ResponseCode.unknownError,
          ResponseMessage.unknownError,
        );
    }
  }
}

extension DataSourceLocalNotificationExtension on DataSourceLocalNotification {
  Failure getFailure() {
    switch (this) {
      case DataSourceLocalNotification.onShowError:
        return Failure(ResponseCode.onShowError, ResponseMessage.onShowError);
      case DataSourceLocalNotification.onCancelAllError:
        return Failure(
            ResponseCode.onCancelAllError, ResponseMessage.onCancelAllError);
      case DataSourceLocalNotification.onCancelOneError:
        return Failure(
            ResponseCode.onCancelOneError, ResponseMessage.onCancelOneError);
      case DataSourceLocalNotification.onInitError:
        return Failure(ResponseCode.onInitError, ResponseMessage.onInitError);
      case DataSourceLocalNotification.onDidReceiveNotificationError:
        return Failure(ResponseCode.onDidReceiveNotificationError,
            ResponseMessage.onDidReceiveNotificationError);
      case DataSourceLocalNotification.onGetDetailsNotificationError:
        return Failure(ResponseCode.onGetDetailsNotificationError,
            ResponseMessage.onGetDetailsNotificationError);
      case DataSourceLocalNotification.onGetSettingIosOrAndroidError:
        return Failure(ResponseCode.onGetSettingIosOrAndroidError,
            ResponseMessage.onGetSettingIosOrAndroidError);
      default:
        return Failure(
          ResponseCode.unknownError,
          ResponseMessage.unknownError,
        );
    }
  }
}

extension DataSourceTimerStateExtension on DataSourceTimer {
  Failure getFailure() {
    switch (this) {
      case DataSourceTimer.isActive:
        return Failure(
            ResponseCode.timerIsActive, ResponseMessage.timerIsActive);
      case DataSourceTimer.isInactive:
        return Failure(
            ResponseCode.timerIsInActive, ResponseMessage.timerIsInActive);
      case DataSourceTimer.timerCancelError:
        return Failure(
            ResponseCode.timerCancelError, ResponseMessage.timerCancelError);
      case DataSourceTimer.errorTimer:
        return Failure(ResponseCode.timerError, ResponseMessage.timerError);
      default:
        return Failure(
          ResponseCode.unknownError,
          ResponseMessage.unknownError,
        );
    }
  }
}
