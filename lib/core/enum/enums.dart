enum AuthenticationStatus { unknown, authenticated, unauthenticated,firstTimeAppOpened}
enum TimerStates {
  initial,
  running,
  stopped,
  resumed,
  error,
  finished,
  resendCodeSuccess,
}
enum AppState{
  authenticated,
  unauthenticatedAndOnBoardingViewed,
  unauthenticatedAndOnBoardingNotViewed,
  unknown
}
enum AvailabilityRating { loading, available, unavailable }
enum imageMaintain
{
  billing,
  counter
}
enum imageRegister
{
  profile,
  id,
  license,
  document,
  carBack,
  carFront,
  carInternal
}
enum Gender
{
  male,
  female
}
enum imageExtension
{
  png,
  jpg,
  jpeg,
  jfif,
  pjpeg,
  pjp,


}
enum DataSourceValidationInput {
  empty,
  usernameStyle,
  shortPassword,
  notIdenticalPassword,
  weakPassword,
  veryLong,
  length,
  maxInputCount,
  notPhoneStyle,
  notEmail,
  notInteger,
  notDouble,
  notBool,
  notString,
  containSpecialChar,
  unknown,
  inValidImg,
  inValidFormat,
  valid
}
enum CheckPhone { registered, unRegistered, unKnown }

enum ConnectionType { wifi, mobile }
enum DataSourceNetworkError {
  success,
  noContent,
  badContent,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  recieveTimeOut,
  sendTimeOut,
  cashError,
  noInternetConnection,
  unknownError
}
enum DataSourceLocationError {
  success,
  locationPermissionDined,
  locationServiceDisabled,
  locationDetectedTimeOut,
  locationUnAvailable,
  locationUpdateError,
  locationAlreadySubscribed,
  locationActivityMissing,

  unknownError,
}
enum DataSourcePermission {
  allow,
  checkPermissionError,
  permissionDenied,
  permissionPermanentlyDenied,
  permissionRestricted,
  unknownPermissionError,
  noImageSelected,
  imageSelected
}
enum DataSourceLaunchUrl {
  success,
  cantNotOpen,
  inValidUrl,
  systemError,
  unKnownLauncherError,
}
enum LangaugeCode {
  ar,
  en,
}
enum DataSourceBatteryState {
  charging,
  discharging,
  errorInfo,
  fullCharging,
  unknownError
}
enum DataSourceTimer {
  isActive,
  isInactive,
  errorTimer,
  timerCancelError,
  unknownError
}
enum DataSourceLocalNotification {
  show,
  onInitError,
  onGetSettingIosOrAndroidError,
  onCancelAllError,
  onCancelOneError,
  onShowError,
  onSelectNotificationError,
  onDidReceiveNotificationError,
  onGetDetailsNotificationError
}

enum StateRendererType {
  //popup state(dialog)
  popupLoadingState,
  popupErrorState,
  //Full screen state (full screen )
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  //general state (content)
  contentState
}
enum AccountState{
  pending,
  active,
  blocked,
  waiting,
  deleted
}
enum StatePage{
  initial,
  loading,
  error,
  empty,
  data,
}