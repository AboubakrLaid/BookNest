import 'package:e_books/local_storage/local_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'theme_modes.dart';

class AppThemeProvider extends ChangeNotifier {
  //
  //*  this is a singleton class that's mean we have only a single app theme state
  //
  static final _instance = AppThemeProvider._();
  AppThemeProvider._();
  factory AppThemeProvider() => _instance;
  //

  static ThemeMode themeMode = ThemeMode.system;

  static bool _isDark =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  bool get isDark => _isDark;

  //

  static get lightTheme => kLightTheme;
  static get darkTheme => kDarkTheme;
  //
  //

  //

  static Future<void> initThemeMode(BuildContext context, LocalStorageProvider x) async {
    // final localDB = Provider.of<LocalStorageProvider>(context, listen: false);
    final localDB = x;

    bool isDarkk = await localDB.isDarkMode() ??
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;

    if (isDarkk == true) {
      themeMode = ThemeMode.dark;
      _isDark = true;
    } else if (isDarkk == false) {
      themeMode = ThemeMode.light;
      _isDark = false;
    }
  }

  Future<void> toggleTheme(BuildContext context) async {
    final localDB = Provider.of<LocalStorageProvider>(context, listen: false);
    switch (themeMode) {
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
        _isDark = true;

      case ThemeMode.dark:
        themeMode = ThemeMode.light;
        _isDark = false;

      case ThemeMode.system:
        // checking the background color of the scaffold
        //! this color will change according to the app theme colors
        if (Theme.of(context).scaffoldBackgroundColor ==
            kLightTheme.scaffoldBackgroundColor) {
          themeMode = ThemeMode.dark;
          _isDark = true;
        } else {
          themeMode = ThemeMode.light;
          _isDark = false;
        }
    }
    print('here');
    print(themeMode);
    await localDB.setTheme(isDark: _isDark);
    notifyListeners();
    print('saved');
  }

  //
  // *use the theme of the device
  void useSystemTheme(BuildContext context) async {
    final localDB = Provider.of<LocalStorageProvider>(context, listen: false);
    themeMode = ThemeMode.system;
    _isDark = SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
    notifyListeners();
    await localDB.setTheme(isDark: _isDark);
  }

  void useDarkLightTheme(BuildContext context, {required bool isDark}) async {
    final localDB = Provider.of<LocalStorageProvider>(context, listen: false);
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _isDark = isDark;

    notifyListeners();
    await localDB.setTheme(isDark: _isDark);
  }
  //
}
