import 'package:hesham/core/resources/app_constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
abstract class LocalNotification{

  AndroidInitializationSettings get getAndroidInitializationSettings;
  IOSInitializationSettings get getIosInitializationSettings;
  InitializationSettings get getInitializationSettings;
  AndroidNotificationDetails get getAndroidNotificationDetails;
  IOSNotificationDetails get getIosNotificationDetails;
  Future<void> initializeLocalNotificationSetting(Function _onSelectNotification);
  Future<void> cancelAllNotification();
  Future<void> cancelNotification(int id);
  NotificationDetails get getNotificationDetails;
  Future<void> showNotification(int id,String title,String body);
  Future<void>onDidReceiveLocalNotification(Function function,int id,String title,String body,String payload);
}
class LocalNotificationImpl implements LocalNotification{

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  LocalNotificationImpl(this._flutterLocalNotificationsPlugin);
  @override
  Future<void> initializeLocalNotificationSetting(Function onSelectNotification)async{

    await _flutterLocalNotificationsPlugin.initialize(getInitializationSettings, onSelectNotification: onSelectNotification.call());
  }
  @override
  NotificationDetails get getNotificationDetails=> NotificationDetails(android: getAndroidNotificationDetails,iOS: getIosNotificationDetails);
  @override
  Future<void> showNotification(int id, String title, String body) async {
   await _flutterLocalNotificationsPlugin.show(id, title, body, getNotificationDetails);
  }
  Future<void> _onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
      onDidReceiveLocalNotification((){},id!,title!,body!,payload!);
  }
  @override
  Future<void> cancelAllNotification() async {
      await _flutterLocalNotificationsPlugin.cancelAll();
  }
  @override
  Future<void> cancelNotification(int id)async{
      await _flutterLocalNotificationsPlugin.cancel(id);
  }
  @override
  AndroidInitializationSettings get getAndroidInitializationSettings =>const AndroidInitializationSettings(AppConstants.appLocalNotificationAndroidIcon);
  @override
  IOSInitializationSettings get getIosInitializationSettings => IOSInitializationSettings(
      requestAlertPermission: AppConstants.appLocalNotificationIosRequestAlertPermission,
      requestBadgePermission: AppConstants.appLocalNotificationIosRequestBadgePermission,
      requestSoundPermission: AppConstants.appLocalNotificationIosRequestSoundPermission,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
  @override
  InitializationSettings get getInitializationSettings => InitializationSettings(android: getAndroidInitializationSettings,iOS: getIosInitializationSettings);
  @override
  AndroidNotificationDetails get getAndroidNotificationDetails => const AndroidNotificationDetails(
      AppConstants.appLocalNotificationAndroidChannelId,
      AppConstants.appLocalNotificationAndroidChannelName,
      channelDescription: AppConstants.appLocalNotificationAndroidChannelDescription,
      enableVibration:  AppConstants.appLocalNotificationIosRequestVibrationPermission,
      playSound: AppConstants.appLocalNotificationIosRequestSoundPermission,
      icon: AppConstants.appLocalNotificationAndroidIcon,
      sound: RawResourceAndroidNotificationSound(AppConstants.appLocalNotificationAndroidSoundName),
      ticker: AppConstants.appLocalNotificationAndroidTicker,
      priority: Priority.max,
      importance: Importance.max,);
  @override
  IOSNotificationDetails get getIosNotificationDetails =>const IOSNotificationDetails(
    sound: AppConstants.appLocalNotificationIosSoundName,
    presentSound: AppConstants.appLocalNotificationIosRequestSoundPermission,
    presentAlert: AppConstants.appLocalNotificationIosRequestAlertPermission,
    presentBadge: AppConstants.appLocalNotificationIosRequestBadgePermission,
  );
  @override
  Future<void> onDidReceiveLocalNotification(Function function,int id,String title,String body,String payload) async{
   await function.call();
  }


}

