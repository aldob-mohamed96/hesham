import 'dart:developer';


 import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'core/enum/enums.dart';
import 'core/preferences/app_prefs.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/app_settiings.dart';
import 'features/business_logic/bloc/auth/auth/authentication_bloc.dart';
import 'features/business_logic/bloc/auth/auth/authentication_state.dart';
import 'features/business_logic/cubit/langauge/langauge_cubit.dart';
import 'features/business_logic/cubit/langauge/localization/app_localizations_setup.dart';
import 'features/business_logic/cubit/notification/notification_cubit.dart';
import 'features/business_logic/cubit/theme/theme_cubit.dart';
import 'features/domain/entities/setting_app.dart';
import 'features/domain/usecases/app_usecase.dart';
import 'features/presentation/routes/app_pages.dart';
import 'features/presentation/routes/app_routes.dart';
import 'core/di/dependency_injection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,DeviceOrientation.landscapeLeft]);
  await initAppServicesGetIt();
  Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) => instance<NotificationCubit>().showNotification(message));
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => instance<NotificationCubit>().showNotification(message));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await instance<AppSettings>().getAppSettings();
  runApp(
   const AppMaterial(),
  );

await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async =>NotificationCubit().showNotification(message);
class AppMaterial extends StatelessWidget {

  const AppMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => instance<AuthenticationBloc>()..isLoggedIn()),
        BlocProvider(create: (_) => instance<ThemeCubit>()..getAppTheme()),
        BlocProvider(create: (_) => instance<LangaugeCubit>()..getAppLangauge()),
        BlocProvider(create: (_) => instance<NotificationCubit>()),


      ],
      child:const AppMaterials(),
    );
  }
}

class AppMaterials extends StatefulWidget {
  const AppMaterials({
    Key? key,
  }) : super(key: key);
  @override
  State<AppMaterials> createState() => _AppMaterialsState();
}

class _AppMaterialsState extends State<AppMaterials> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().autoUpdateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {

      final local = context.select((LangaugeCubit langaugeCubit) => langaugeCubit.state.locale);

      return MaterialApp(
        builder: (context, child) {
          return MultiBlocListener(child: child!, listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
                child: child,
                listener: (cont, state) async {
                  switch (state.authenticationStatus) {
                    case AuthenticationStatus.authenticated:
                          Future.delayed(const Duration(seconds: 5),(){
                            _navigator.pushReplacementNamed(Routes.homeRoot);

                          });
                         break;
                    case AuthenticationStatus.unauthenticated:
                        Future.delayed(const Duration(seconds: 5),(){
                          _navigator.pushReplacementNamed(Routes.loginRoot);

                        });
                         break;
                    case AuthenticationStatus.firstTimeAppOpened:
                      Future.delayed(const Duration(seconds: 5),(){
                        _navigator.pushReplacementNamed(Routes.onBoardingRoot);

                      });

                         break;
                    case AuthenticationStatus.unknown:
                    default:
                     Future.delayed(const Duration(seconds: 5),(){
                       _navigator.pushReplacementNamed(Routes.unDefineRoute);

                     });

                  }
                })
          ]);
        },
        useInheritedMediaQuery: true,
        onGenerateRoute: instance<AppRouter>().onGenerateRoute,
        initialRoute: Routes.splashRoot,
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        themeMode: ThemeMode.light,
        locale: local,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallBack,
        theme: instance<ThemeManager>().getLightTheme,

      );
    });
  }


}
