import 'package:bloc/bloc.dart';
import 'package:hesham/core/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeManager themeManager;
  ThemeCubit({required this.themeManager}) : super(ThemeState(themeMode: ThemeMode.light));

  Future<void> getAppTheme()async
  {
    final themeMode=themeManager.getThemeMode();

    emit(ThemeState(themeMode: themeMode));

  }
  Future<void> changeAppTheme() async
  {
    final theme=state.themeMode==ThemeMode.light?ThemeMode.dark:ThemeMode.light;
    await themeManager.setThemeMode(theme);

    emit(ThemeState(themeMode: theme));
  }

  void autoUpdateAppTheme()
  {
    final Brightness currentBrightness=themeManager.currentSystemBrightness;
    currentBrightness==Brightness.light? _setTheme(ThemeMode.light):_setTheme(ThemeMode.dark);
  }

  Future<void> _setTheme(ThemeMode themeMode)async
  {
   await themeManager.setThemeMode(themeMode);
   emit(ThemeState(themeMode: themeMode));
  }

}
