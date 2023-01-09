// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hesham/core/resources/strings_manager.dart';

import '../../features/business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../features/domain/entities/failure.dart';
import '../../features/domain/entities/setting_app.dart';
import 'assets_manager.dart';
import 'color_manager.dart';

class AppConstants {
//hash code otp for ios
  static const String hashCodeForIos = "ios";

//loading const String
  static const String loading = "loading";

//validation
  static const String usernameValidationLength = '';
  static const String usernameValidationFormate = '';
  static const String passwordValidationLength = '';
  static const String nameValidationLength = '';
  static const String confirmPasswordValidationNotEqualPassword = '';
  static const String appCashedNotificationItemsResponse = 'appCashedNotificationItemsResponse';
  static const String validationTrue = 'true';
  static const List<String> maintainListType= <String>[
  AppStrings.selectMaintenanceType,
  AppStrings.changeOil,
  AppStrings.changeOilAndFilter,
  AppStrings.changeRound,
  AppStrings.changeBattery,
  AppStrings.changeGlass,
  AppStrings.changeOther
  ];
//code verification
  static const int verificationCodeLength = 4;

//loading widget parameter
  static const double strokeWidth = 4.0;
  static const Color backgroundCircularLoading =
      ColorManager.backgroundColorCircularLoading;

//snack bar  widget parameter
  static const Color backgroundCircularSnackBar =
      ColorManager.backgroundColorCircularLoading;


 //app File

//key of sharedPreferences

  static const String appLanguagePrefsKey = "PREFS_KEY_LANG";
  static const String appThemeModePrefsKey = "PREFS_KEY_THEME_MODE";
  static const String appOnBoardingIsViewedPrefsKey = "PREFS_KEY_ON_BOARDING_IS_VIEWED";
  static const String appTokenUserPrefsKey = "PREFS_KEY_APP_TOKEN_USER";
  static const String appUserIsLoggedInPrefsKey = "PREFS_KEY_USER_IS_LOGGED_IN";
  static const String appCashedAuthenticationResponse = "PREFS_KEY_CASHED_AUTH_RESPONSE";
  static const String appCashedDriverOrderSDataResponse = "PREFS_KEY_CASHED_DRIVER_ORDERS_DATA_RESPONSE";
  static const String appCashedDriverMaintainDataResponse = "PREFS_KEY_CASHED_DRIVER_MAINTAIN_DATA_RESPONSE";
  static const String appCashedHomeDataResponse = "PREFS_KEY_CASHED_HOME_RESPONSE";
  static const String appCashedDriverCovenantSDataResponse = "PREFS_KEY_CASHED_DRIVER_COVENANT_DATA_RESPONSE";
  static const String appCashedDriverTransactionsDataResponse = "PREFS_KEY_CASHED_DRIVER_TRANSACTION_DATA_RESPONSE";

  static const int appCashedAuthenticationResponseTimeInterval = 60 * 1000*10;

// default value of primitive
  static const String defaultEmptyString = "";
  static const String defaultEmptyJsonList = '{"status":1,"success":true,"message":"successfully Data","errorId":null,"data":[]}';
  static const String defaultEmptyJsonHome = '{"status":1,"success":true,"message":"successfully Data","errorId":null,"data":{}}';
  static const String defaultEmptyJsonPagination = '{"status":1,"success":true,"message":"successfully Data","errorId":null,"data":{}}';
  static const String defaultPhone = "0509040954";
  static const String defaultEmergency = "999";
  static const String defaultGmail = "jwabtaxi@gmail.com";


  static const int defaultEmptyInteger = 0;
  static const double defaultEmptyDouble = 0.0;
  static const bool defaultEmptyBool = false;
  static const List<String> defaultEmptyListString = [];
  static const List<dynamic> defaultEmptyGenericList = [];

//onBoarding screen
  static const int timeDelayOnBoardingScreen = 4;

//value not fount
  static const int valueIntNotFount = -1;
  static const double valueDoubleNotFount = -1.0;

//timer tricker
  static const Duration timerDurationTick = Duration(seconds: 1);
  static const int timerDuration = 40;
  static const Failure inCorrectCode = Failure(-223, AppStrings.inValidCode);
  static const Failure accountPendingFailure = Failure(-1223, AppStrings.authAccountBlocked);
  static const Failure unknownFailure = Failure(0000, AppStrings.unknownError);
  static const Failure unknownUplodedBefore = Failure(0000, AppStrings.uploadedBefore);
  static const Failure maintainFailure = Failure(0110, AppStrings.unknownError);
//default core Setting theme ...language

  static const String defaultThemeModeApp = 'light';
  static const String lightTheme = "light";
  static const String darkTheme = "dark";
  static const String systemTheme = "system";
  static const ThemeMode defaultTheme = ThemeMode.light;

  static const String defaultLanguageAppCode = "en";
  static const String arabicLanguageCode = "ar";
  static const String englishLanguageCode = "en";
  static const Locale englishLocal = Locale("en", '');
  static const Locale defaultLocal = Locale("en", '');
  static const Locale arabicLocal = Locale("ar", '');
  static const Iterable<Locale> supportedLocales = [
    AppConstants.englishLocal,
    AppConstants.arabicLocal
  ];
  static const List<String> supportedLangauge = [
    AppConstants.arabicLanguageCode,
    AppConstants.englishLanguageCode
  ];
  static const String assetLocalizationPath = "assets/translations/";

  static const String appVersion = "1.0.0";
  static const String iosVersion = "1.0.0";
  static const bool forceUpdateVersion = true;
  static const String enableVersion = "1";
  static const String appName = AppStrings.appName;
  static const baseUrls = "https://rtltec.com/api";
  // static const baseUrls ="http://dob.taxialjawabb.com/api";
  static const baseUrlsDebug = "https://rtltec.com/api";
 // static const baseUrlsDebug = "http://dob.taxialjawabb.com/api";

//select image or camera
  static const String welcomeMessage = "Hi,...";
  static const String shareAppMessage = '''
  Taxi Aljwab for Android App
  https://play.google.com/store/apps/details?id=com.taxialjawabb.aljwab_driver.aljwab_driver
  Taxi Aljwab for Ios App
  https://apps.apple.com/us/app/%D9%83%D8%A7%D8%A8%D8%AA%D9%86-%D8%A7%D9%84%D8%AC%D9%88%D8%A7%D8%A8/id1626634706
  ''';

//scheme url launcher
  static const String telSchemeUrlLauncher = "tel://";
  static const String mailSchemeUrlLauncher = "mailto:";
  static const String linkSchemeUrlLauncher = "https";

// link map
  static const String googleMapUrl1 =
      'https://www.google.com/maps/search/?api=1&query=';
  static const String appleMapUrl = 'https://maps.apple.com/?sll=';

//DateTime
  static const int year = 2022;
  static const int month = 1;
  static const int day = 1;
  static const int hour = 1;
  static const int minute = 1;
  static const int second = 1;
  static const int millSecond = 1;
  static const int microSecond = 1;
  static DateTime dateTime =
      DateTime(year, month, day, hour, minute, second, millSecond, microSecond);

// image size camera and gallery picker
  static const double maxWidthImgPickerCamera = 1800.0;
  static const double maxWidthImgPickerGallery = 1800.0;
  static const int qualityImgPickerGallery =
      60; //quality in Percentage 0....100 %
  static const double maxHeightImgPickerCamera = 1800.0;
  static const double maxHeightImgPickerGallery = 1800.0;
  static const int qualityImgPickerCamera = 60;
  static const String zeroString = "0";
 // local Notification
  static const String appLocalNotificationAndroidIcon = "@drawable/splash";
  static const String appLocalNotificationAndroidSoundName = "sound";
  static const String appLocalNotificationIosSoundName = "soundnote.aiff";
  static const String appLocalNotificationAndroidTicker = "'ticker'";
  static const String appLocalNotificationAndroidChannelId =
      "high_importance_channel";
  static const String appLocalNotificationAndroidChannelName = "channel_name";
  static const String appLocalNotificationAndroidChannelDescription =
      "description";
  static const bool appLocalNotificationIosRequestAlertPermission = true;
  static const bool appLocalNotificationIosRequestBadgePermission = true;
  static const bool appLocalNotificationIosRequestSoundPermission = true;
  static const bool appLocalNotificationIosRequestVibrationPermission = true;
  static const List<String> imagesSlide=<String>[
    ImagesAssetsManage.mock2,
    ImagesAssetsManage.mock3,
    ImagesAssetsManage.mock3,

  ];
//database Sqflite
  static const String databasePath = 'databaseName.db';
  static const int databaseVersion = 1;


  //key input field
  static const String keyUsernameFiled = 'CheckPhoneForm_usernameInput_textField';
  static const String keyNameFiled = 'ChangeNameForm_nameInput_textField';
  static const String keyAddressFiled = 'RegisterForm_AddressInput_textField';
  static const String keyCounterValueFiled = 'MaintainForm_CounterInput_textField';
  static const String keyMaintainNoteFiled = 'MaintainForm_NoteInput_textField';
  static const String keyMaintainTypeFiled = 'MaintainForm_TypeInput_textField';
  static const String keyEmailFiled = 'ChangeEmailForm_emailInput_textField';
  static const String keySaveButton = 'SaveButtonForm_textField';
  static const String keyUsernameForgetFiled = 'CheckPhoneForm_usernameForgetInput_textField';
  static const String keyPasswordFiled = 'loginForm_passwordInput_textField';
  static const String keyConfirmPasswordFiled = 'loginForm_confirmPasswordInput_textField';
  static const String keyPinCodeFiled = 'loginForm_pinCodeInput_textField';
  static const String keyCheckPhoneButtonFiled = 'CheckPhoneForm_next_Button';
  static const String keyForgetButtonFiled = 'ForgetPasswordForm_next_Button';
  static const String keyLoginButtonFiled = 'loginForm_next_Button';
  static const String keyVerificationButtonFiled = 'verificationForm_next_Button';
  static const String keyForgetPasswordButtonFiled = 'ForgetPasswordForm_next_Button';
  static const String keyResendCodeButtonFiled = 'ResendCodeButtonFiledForm_next_Button';
  static const int usernameLength = 10;
//input Error String
  static const String emptyInput = AppStrings.emptyInput;
  static const String usernameStyleInput = AppStrings.usernameStyleInput;
  static const String shortPasswordInput = AppStrings.shortPasswordInput;
  static const String notIdenticalPasswordInput = AppStrings.notIdenticalPasswordInput;
  static const String weakPasswordInput = AppStrings.weakPasswordInput;
  static const String veryLongInput = AppStrings.veryLongInput;
  static const String lengthInput = AppStrings.lengthInput;
  static const String maxInputCountInput = AppStrings.maxInputCountInput;
  static const String notPhoneStyleInput = AppStrings.notPhoneStyleInput;
  static const String notEmailInput = AppStrings.notEmailInput;
  static const String notIntegerInput = AppStrings.notIntegerInput;
  static const String notDoubleInput = AppStrings.veryLongInput;
  static const String notBoolInput = AppStrings.notBoolInput;
  static const String notStringInput = AppStrings.notStringInput;
  static const String containSpecialCharInput = AppStrings.containSpecialCharInput;
  static const String unknownInput = AppStrings.unknownInput;
  static const String validInput = AppStrings.validInput;
  static const String inValidInput = AppStrings.invalidInput;



  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(AppLocalizationsImpl.of(context)!.translate(message))));
  }
}

class LocationSettingConstant {


  //android Setting location
  static const String notificationTextForegroundAndroidLocation =
      AppStrings.notificationTextForegroundAndroidLocation;
  static const String notificationTitleForegroundAndroidLocation =
      AppStrings.notificationTitleForegroundAndroidLocation;
  static const bool enableWakeLockForegroundAndroidLocation = false;
  static const bool enableWifiLockForegroundAndroidLocation = false;
  static const String notificationIconForegroundAndroidLocation =
      "@drawable/splash";
  static const bool enableForceLocationManagerAndroid = false;
  static const Duration intervalDurationLocationAndroid = Duration.zero;
  static const Duration timeLimitLocationAndroid = Duration.zero;
  static const int distanceFilterLocationAndroid = 100;

  //apple Setting Location
  static const Duration timeLimitLocationIos = Duration.zero;
  static const int distanceFilterLocationIos = 100;
  static const bool pauseLocationUpdatesAutomaticallyIos = false;
  static const bool showBackgroundLocationIndicatorIos = false;

  //other PlatForm
  static const Duration timeLimitLocationOtherPlatForm = Duration.zero;

  static const int distanceFilterLocationOtherPlatForm = 100;
}

class NetworkConstant {
  static const String APPLICATION_JSON = "application/json";
  static const String CONTENT_TYPE = "content-type";
  static const String ACCEPT = "accept";
  static const String PHONE_ID = "phone_id";
  static const String DEVICE_TOKEN = "device_token";
  static const String AUTHORIZATION = "authorization";
  static const String AUTH_TOKEN = "auth-token";

  static const String API_PASSWORD = "api_password";
  static const String API_PASSWORD_VALUE = "N3n2I4iC2FVdyr2a4NoFXwFiijsJQgc5Zn4UFFPS";

  static const String DEFAULT_LANGUAGE = "language";
  static const int apiTimeOut = 60000;
  static const String TOKEN_VALUE = "";
  static const String PHONE = "phone";
  static const String PAGE = "page";
  static const String TYPE_VERIFICATION = "type_verification";
  static const String TYPE_VERIFICATION_HAS_ACCOUNT = "hasAccount";
  static const String TYPE_VERIFICATION_HAS_NOT_ACCOUNT = "hasNotAccount";
  static const String PASSWORD = "password";
  static const String USERNAME = "username";
  static const String NAME = "name";
  static const String ADDRESS = "address";
  static const String IMG_PROFILE = "img_profile";
  static const String IMG_ID = "img_id";
  static const String IMG_DOCUMENT = "img_document";
  static const String IMG_LICENSE = "img_license";
  static const String IMG_CAR_FRONT = "img_front";
  static const String IMG_CAR_BACK = "img_car_back";
  static const String IMG_CAR_INTERNAL = "img_car_internal";




  //urls
  static const String checkPhoneUrl =  "/check/phone";
  static const String loginUrl =  "/login";
  static const String changePasswordUrl =  "/modify/password";
  static const String changeEmailUrl =  "/modify/email";
  static const String changePhoneUrl =  "/modify/phone";
  static const String verificationCodeUrl =  "/send/message";
  static const String registerUrl =  "/register";
  static const String orderTripsUrl =  "/trips?page=";
  static const String logoutUrl =  "/logout";
  static const String deleteAccountUrl =  "/delete/account";
  static const String homeUrl =  "/subjects";
  static const String attendance =  "/attendance";
  static const String contacts =  "/contact/show";
  static const String notes =  "/notification/show";
  static const String addContacts =  "/contact/add";
  static const String sheet =  "/sheet";
  static const String bondsTripsUrl =  "/bond?page=";
  static const String maintainUrl =  "/maintenance/show?page=";
  static const String addMaintainUrl =  "/maintenance/add";
  static const String covenantUrl =  "/covenant/show";
  static const String lesson =  "/lessons/";


}

class ErrorCode{
  static const String unknownError = "0000";
  static const String authAccountDeleted = "0001";
  static const String authAccountBlocked = "0002";
  static const String authVerificationCodeNotSend = "0003";
  static const String authDataInValidData = "0004";
  static const String authThisDataExists = "0005";
}