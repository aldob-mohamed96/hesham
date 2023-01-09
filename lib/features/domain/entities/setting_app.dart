import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/enum/enums.dart';

class SettingApp extends Equatable{
  final String route;
  final ThemeMode themeMode;
  final Locale locale;


 const SettingApp({this.route=Routes.onBoardingRoot, this.themeMode=AppConstants.defaultTheme, this.locale=AppConstants.defaultLocal});
  SettingApp copyWith({
    String? route,
    ThemeMode? themeMode,
    Locale? locale,
  })
  {
    return SettingApp(
        locale: locale??this.locale,
        themeMode: themeMode??this.themeMode,
        route: route??this.route
    );
  }

  @override
  List<Object?> get props => [route,themeMode,locale];

}