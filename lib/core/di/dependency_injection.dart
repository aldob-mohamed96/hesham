import 'package:hesham/core/resources/langauge_manager.dart';
import 'package:hesham/core/resources/theme_manager.dart';
import 'package:hesham/features/business_logic/bloc/auth/auth/authentication_bloc.dart';
import 'package:hesham/features/business_logic/bloc/auth/login/login_bloc.dart';
import 'package:hesham/features/business_logic/bloc/home/home_bloc.dart';
import 'package:hesham/features/business_logic/cubit/notification/notification_cubit.dart';
import 'package:hesham/features/presentation/routes/app_pages.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/business_logic/bloc/maintain/maintain_bloc.dart';
import '../../features/business_logic/bloc/note/note_bloc.dart';
import '../../features/business_logic/cubit/langauge/langauge_cubit.dart';
 import '../../features/business_logic/cubit/theme/theme_cubit.dart';
import '../../features/data/data_source/local/app_local.dart';
import '../../features/data/data_source/remote/app_remote.dart';
import '../../features/data/network/api/auth/app_api.dart';
import '../../features/data/network/network_factory/dio_factory.dart';
import '../../features/data/repositories_impl/app_impl.dart';
import '../../features/domain/repositories/app_repository.dart';
import '../../features/domain/usecases/app_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/presentation/common/widget/dialog_snackbar.dart';
import '../preferences/app_prefs.dart';
import '../services/app_settiings.dart';
import '../services/firbase.dart';
import '../services/network_info.dart';
import '../services/permission.dart';
import '../services/picker_gallery_camera.dart';

final instance = GetIt.instance;
Future<void> initAppServicesGetIt() async {
  //-------------------------External---------------------------------
  final sharedPreferences = await SharedPreferences.getInstance();

  instance.registerLazySingleton(() => sharedPreferences);
  instance.registerLazySingleton(() => InternetConnectionChecker());
  instance.registerLazySingleton<DioFactory>(() => DioFactoryImpl());
  Dio dio = await instance<DioFactory>().getDio();

  //------------------------permission-------------------------


  instance.registerLazySingleton<PermissionHandling>(() => PermissionHandlingImpl());

  //-------------------------Show Message dialog and snackbar---------------------------------
  instance.registerLazySingleton<ShowMessage>(() => ShowMessageImpl());
  //-------------------------AppRouter---------------------------------
  instance.registerLazySingleton<AppRouter>(() => AppRouterImpl());
  //-------------------------Api AppService Api Client---------------------------------
  instance.registerLazySingleton<AppServiceApiClient>(() => AppServiceApiClient(dio));



  //-------------------------Core---------------------------------

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(instance()));
  instance.registerLazySingleton<FirebaseData>(() => FirebaseDataImpl());

  //-------------------------DataSources---------------------------------

  instance.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImp(instance()));
  instance.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(instance()));


  //-------------------------AuthRepository---------------------------------
  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(instance(), instance(), instance()));
  //-------------------------AuthUseCase---------------------------------
  instance.registerLazySingleton<AuthenticationUseCase>(() => AuthenticationUseCase(instance())..isLoggedIn());
  //-------------------------url launcher---------------------------------

  //-------------------------Setting App---------------------------------


  instance.registerLazySingleton<AppSettingPreferences>(() => AppSettingPreferencesImpl(sharedPreferences));
  instance.registerLazySingleton<ThemeManager>(() => ThemeManagerImpl(appSettingPreferences: instance()));
  instance.registerLazySingleton<LangaugeManager>(() => LangaugeManagerImpl(instance()));
  //------------------------ app Setting --------------------------
  instance.registerLazySingleton<AppSettings>(() => AppSettingImpl(appSettingPreferences:  instance(),themeManager:  instance(),authenticationUseCase: instance(),langaugeManager: instance()));

  //-------------------------Bloc---------------------------------
  instance.registerLazySingleton(() => AuthenticationBloc(authenticationUseCase: instance(),));
  instance.registerLazySingleton(() => ThemeCubit(themeManager: instance()));
  instance.registerLazySingleton(() => LangaugeCubit(langaugeManager: instance()));
  instance.registerLazySingleton(() => NotificationCubit());
}


authLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<LoginBloc>()) {
    instance.registerFactory(() => LoginBloc(loginUseCase: instance()));
  }
}


homeModule() {

  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<AttendanceUseCase>()) {
    instance.registerFactory<AttendanceUseCase>(() => AttendanceUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<SheetUseCase>()) {
    instance.registerFactory<SheetUseCase>(() => SheetUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<PermissionHandling>()) {
    instance.registerFactory<PermissionHandling>(() => PermissionHandlingImpl());
  }
  if (!GetIt.I.isRegistered<LogoutUseCase>()) {
    instance.registerFactory<LogoutUseCase>(() => LogoutUseCase(instance()));
  }

  if (!GetIt.I.isRegistered<HomeBloc>()) {
    instance.registerFactory<HomeBloc>(() => HomeBloc(logoutUseCase: instance(),permissionHandling: instance(),homeUseCase: instance(),attendanceUseCase:instance() ,sheetUseCase: instance()));
  }

}


contactModule() {

  if (!GetIt.I.isRegistered<AddContactUseCase>()) {
    instance.registerFactory<AddContactUseCase>(() => AddContactUseCase(instance()));
  }


  if (!GetIt.I.isRegistered<ContactUseCase>()) {
    instance.registerFactory<ContactUseCase>(() => ContactUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<MaintainBloc>()) {
    instance.registerFactory<MaintainBloc>(() => MaintainBloc(addContactUseCase: instance(),contactUseCase: instance()));
  }

}

noteModule() {

  if (!GetIt.I.isRegistered<NoteUseCase>()) {
    instance.registerFactory<NoteUseCase>(() => NoteUseCase(instance()));
  }


  if (!GetIt.I.isRegistered<NoteBloc>()) {
    instance.registerFactory<NoteBloc>(() => NoteBloc(contactUseCase: instance()));
  }

}





