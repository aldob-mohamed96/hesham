class ApiInternalStatusCode{
  static const int failure=0;
  static const int success=1;
  static const int maintain=2;
  static const int unAuthenticated=3;


}
class ApiInternalStatusLocationCode{
  static const String ok="OK";
  static const String error="error";

}
class ResponseCode
{
  //http response code
  static const int success=200;
  static const int noContent=201;
  static const int badContent=400;
  static const int unAuthorised=401;
  static const int forbidden=403;
  static const int internalServerError=200;
  static const int notFound=404;

  //local error code http not executed
  static const int connectTimeOut=-1000;
  static const int cancel=-1002;
  static const int recieveTimeOut=-1003;
  static const int sendTimeOut=-1004;
  static const int cashError=-1005;
  static const int noInternetConnection=-1006;
  static const int unknownError=-1007;

  //location error
  static const int locationPermissionDined=2000;
  static const int locationUnAvailable=2001;
  static const int locationDetectedTimeOut=2002;
  static const int locationServiceDisabled=2003;
  static const int locationUpdateError=2004;
  static const int locationAlreadySubscribed=2005;
  static const int locationActivityMissing=2006;

  //permission handling
  static const int permissionDined=2020;
  static const int permissionCheckError=2021;
  static const int unknownPermissionError=2022;
  static const int noImageSelected=2023;
  static const int allow=2015;
  static const int permissionPermanentlyDenied=2024;
  static const int permissionRestricted=2025;
  static const int imageSelected=2026;

  //launch Url
  static const int cantNotOpen=3000;
  static const int inValidUrl=3001;
  static const int systemError=3002;
  static const int unKnownLauncherError=3003;

  //Battery state
  static const int batteryInfoError=4000;

  //Timer State
  static const int timerIsActive=4000;
  static const int timerIsInActive=4001;
  static const int timerCancelError=4002;
  static const int timerError=4003;

  //local notification
  static const int onInitError=5000;
  static const int onGetSettingIosOrAndroidError=5001;
  static const int onCancelAllError=5002;
  static const int onCancelOneError=5003;
  static const int onShowError=5004;
  static const int onSelectNotificationError=5005;
  static const int onDidReceiveNotificationError=5006;
  static const int onGetDetailsNotificationError=5007;

  //auth Error

  static const int maintainApp = 999999;
  static const int updateApp = 888888;
  static const int unAuthenticated = 777777;
  static const int pendingAccount = 666666;

  static const int authAccountDeleted = 100001;
  static const int authAccountBlocked = 100002;
  static const int authVerificationCodeNotSend = 100003;
  static const int authLoginInvalidData = 100004;
  static const int maintenanceNotAdded = 100005;
  static const int authThisDataExistsRegister = 100006;
  static const int authRegisterError = 100007;
  static const int notExistAccount = 100008;
  static const int missMatchPassword = 100009;
  static const int tripNotExist = 100010;
  static const int notEnoughMoney = 100011;
  static const int transferDataNotCorrect = 100012;
  static const int dataNotCorrect14 = 100014;
  static const int dataNotCorrect15 = 100015;
  static const int dataNotCorrect16 = 100016;
  static const int dataNotCorrect17 = 100017;






}