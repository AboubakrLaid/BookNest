import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  factory LocalStorage() {
    _instance._init();
    return _instance;
  }

  SharedPreferences? _preferences;

  get preferences => _preferences;

  Future<void> _init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _init();
    await _preferences?.clear();
  }
 
  Future<void> setTheme({required bool isDark}) async {
    await _preferences?.setBool("isDark", isDark);
  }

  Future<bool?> isDarkMode() async {
    return _preferences?.getBool("isDark");
  }

  Future<void> markOnboardingDone() async {
    await _preferences?.setBool("onboarding", true);
  }

  Future<bool?> isOnboardingDone() async {
    return _preferences?.getBool("onboarding");
  }
}
