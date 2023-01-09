import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'values_manager.dart';
import 'font_manager.dart';
import 'color_manager.dart';
import 'app_constant.dart';
import 'style_manager.dart';
import '../../core/preferences/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeManager {
  ThemeData get getLightTheme;
  ThemeData get getDarkTheme;
  ThemeMode getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
  Brightness get currentSystemBrightness;
}

class ThemeManagerImpl extends ThemeManager {
  final AppSettingPreferences appSettingPreferences;
  ThemeManagerImpl({required this.appSettingPreferences});

  @override
  ThemeData get getLightTheme => _getLightTheme();

  @override
  ThemeData get getDarkTheme => _getDarkTheme();

  _getLightTheme() => ThemeData(
        fontFamily: 'Montserrat',

        primarySwatch: ColorManager.primarySwatchLightColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        /* ---------------------------------------- colors values ----------------------------------*/
        primaryColor: ColorManager.primaryColor,
        backgroundColor: ColorManager.hintColor,
        brightness: Brightness.light,
        dividerColor: ColorManager.primaryColor,
        focusColor: ColorManager.primaryColor,
        hintColor: ColorManager.primaryColor,
        splashColor: ColorManager.primaryColor,

        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: ColorManager.primaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(

          filled: true,
          fillColor: ColorManager.primaryColorLight,
          iconColor: ColorManager.primaryColor,
          prefixIconColor: ColorManager.primaryColor,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppPadding.appPadding16,
              vertical: AppPadding.appPadding16),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
        /* ------------------------------------------ themes style --------------------------------- */
        //AppBar Theme style
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: ColorManager.primaryColor),
        //AppBar Theme style
        appBarTheme: AppBarTheme(
            backgroundColor: ColorManager.secondColor,
            centerTitle: true,
            elevation: AppSize.appSize0,
            titleTextStyle: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSize.fontSize16)),
        //Card Theme style
        cardTheme: CardTheme(
            color: ColorManager.whiteColor,
            elevation: AppSize.appSize10,
            shadowColor: ColorManager.primaryColor),
        //elevated Button Theme style
        iconTheme: IconThemeData(
            color: ColorManager.secondColor, size: AppSize.appSize40),

        //Button Theme style
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: AppSize.appSize0_10,
            backgroundColor: ColorManager.secondColor),
        buttonTheme: ButtonThemeData(
            shape: const StadiumBorder(),
            disabledColor: ColorManager.primaryColor,
            splashColor: ColorManager.primaryColor,
            buttonColor: ColorManager.focusColor),
        //text Button Theme style
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: ColorManager.primaryColor),
        ),
        //color scheme style
        colorScheme: ColorScheme.light(
          primary: ColorManager.primaryColor,
          secondary: ColorManager.primaryColor,
        ),
        //theme input
        textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontSize: FontSize.fontSize20,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.secondColor,
              height: AppSizeMin.appSizeMin1_2),
          headlineSmall: TextStyle(
              fontSize: FontSize.fontSize22,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_2),
          headlineLarge: TextStyle(
              fontSize: FontSize.fontSize16,
              fontWeight: FontWeightManager.light,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_4),
          titleSmall: TextStyle(
              fontSize: FontSize.fontSize16,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_4),
          titleMedium: TextStyle(
              fontSize: FontSize.fontSize14,
              fontWeight: FontWeightManager.simaBold,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_2),
          bodyMedium: TextStyle(
              fontSize: FontSize.fontSize14,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_2),
          bodySmall: TextStyle(
              fontSize: FontSize.fontSize12,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_2),
          bodyLarge: TextStyle(
              fontSize: FontSize.fontSize12,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.primaryColor,
              height: AppSizeMin.appSizeMin1_2),
        ),
      );
  _getDarkTheme() => ThemeData(
      primarySwatch: ColorManager.primarySwatchDarkColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      /* ---------------------------------------- colors values ----------------------------------*/
      primaryColor: ColorManager.primaryColorDark,
      backgroundColor: ColorManager.primaryColorDark,
      brightness: Brightness.light,
      dividerColor: ColorManager.primaryColorDark,
      focusColor: ColorManager.primaryColorDark,
      hintColor: ColorManager.primaryColorDark,
      splashColor: ColorManager.primaryColorDark,
      /* ------------------------------------------ themes style --------------------------------- */
      //AppBar Theme style
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0, foregroundColor: ColorManager.primaryColor),
      //AppBar Theme style
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primaryColor,
          shadowColor: ColorManager.primaryColor,
          elevation: AppSize.appSize4,
          titleTextStyle: getRegularStyle(
              color: ColorManager.primaryColor, fontSize: FontSize.fontSize16)),
      //Card Theme style
      cardTheme: CardTheme(
          color: ColorManager.primaryColor,
          elevation: AppSize.appSize4,
          shadowColor: ColorManager.primaryColor),
      //elevated Button Theme style
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.appSize12)),
              primary: ColorManager.focusColor,
              textStyle: getRegularStyle(
                color: ColorManager.focusColor,
                fontSize: FontSize.fontSize14,
              ))),
      //Button Theme style
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.primaryColor,
          splashColor: ColorManager.primaryColor,
          buttonColor: ColorManager.focusColor),
      //text Button Theme style
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: ColorManager.primaryColor),
      ),
      //color scheme style
      colorScheme: ColorScheme.light(
        primary: ColorManager.primaryColor,
        secondary: ColorManager.primaryColor,
      ),
      //theme input
      textTheme: TextTheme(
        headlineMedium: TextStyle(
            fontSize: FontSize.fontSize20,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_2),
        headlineSmall: TextStyle(
            fontSize: FontSize.fontSize22,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_2),
        headlineLarge: TextStyle(
            fontSize: FontSize.fontSize16,
            fontWeight: FontWeightManager.light,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_4),
        titleSmall: TextStyle(
            fontSize: FontSize.fontSize16,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_4),
        titleMedium: TextStyle(
            fontSize: FontSize.fontSize14,
            fontWeight: FontWeightManager.simaBold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_2),
        bodyMedium: TextStyle(
            fontSize: FontSize.fontSize14,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_2),
        bodySmall: TextStyle(
            fontSize: FontSize.fontSize12,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_2),
        bodyLarge: TextStyle(
            fontSize: FontSize.fontSize12,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.primaryColor,
            height: AppSizeMin.appSizeMin1_2),
      ),
      //theme input
      inputDecorationTheme: InputDecorationTheme(
        //content padding value
        contentPadding: const EdgeInsets.all(AppPadding.appPadding8),
        //hint style
        hintStyle: getRegularStyle(
            color: ColorManager.primaryColor, fontSize: FontSize.fontSize14),
        //label style
        labelStyle: getMediumStyle(
            color: ColorManager.primaryColor, fontSize: FontSize.fontSize14),
        //error style
        errorStyle: getMediumStyle(
            color: ColorManager.primaryColor, fontSize: FontSize.fontSize14),
        //enabled Border error border style
        enabledBorder: OutlineInputBorder(
            borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.appSize8)),
            borderSide: BorderSide(
                color: ColorManager.primaryColor,
                width: AppSizeMin.appSizeMin1_4)),
        //focused  border style
        focusedBorder: OutlineInputBorder(
            borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.appSize8)),
            borderSide: BorderSide(
                color: ColorManager.primaryColor,
                width: AppSizeMin.appSizeMin1_4)),
        //error border style
        errorBorder: OutlineInputBorder(
            borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.appSize8)),
            borderSide: BorderSide(
                color: ColorManager.primaryColor,
                width: AppSizeMin.appSizeMin1_4)),
        //focused error border style
        focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.appSize8)),
            borderSide: BorderSide(
                color: ColorManager.primaryColor,
                width: AppSizeMin.appSizeMin1_4)),
      ));

  @override
  ThemeMode getThemeMode() {
    final themeMode = appSettingPreferences.getAppTheme();
    switch (themeMode) {
      case AppConstants.lightTheme:
        _setStatusBarAndNavigationBarColors(
            SystemUiOverlayStyle.light, ColorManager.lightThemeColor);
        return ThemeMode.light;
      case AppConstants.darkTheme:
        _setStatusBarAndNavigationBarColors(
            SystemUiOverlayStyle.dark, ColorManager.darkThemeColor);
        return ThemeMode.dark;
      case AppConstants.systemTheme:
        return ThemeMode.system;
      default:
        if (AppConstants.defaultThemeModeApp == AppConstants.darkTheme) {
          _setStatusBarAndNavigationBarColors(
              SystemUiOverlayStyle.dark, ColorManager.darkThemeColor);
          return ThemeMode.dark;
        } else {
          _setStatusBarAndNavigationBarColors(
              SystemUiOverlayStyle.light, ColorManager.lightThemeColor);
          return ThemeMode.light;
        }
    }
  }

  void _setStatusBarAndNavigationBarColors(
      SystemUiOverlayStyle overlayStyle, Color color) {
    overlayStyle == SystemUiOverlayStyle.dark
        ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
            .copyWith(
                statusBarBrightness: Brightness.light,
                systemNavigationBarIconBrightness: Brightness.light,
                systemNavigationBarDividerColor: ColorManager.transparentColor,
                systemNavigationBarColor: color))
        : SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: color,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: ColorManager.transparentColor,
          ));
  }

  @override
  Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await appSettingPreferences.setAppTheme(themeMode.name);
    _setStatusBarAndNavigationBarColors(
        themeMode == ThemeMode.light
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.light,
        themeMode == ThemeMode.light
            ? ColorManager.lightThemeColor
            : ColorManager.darkThemeColor);
  }
}
