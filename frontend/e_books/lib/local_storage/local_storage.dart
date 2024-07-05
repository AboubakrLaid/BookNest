import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  factory LocalStorage() {
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
    await _init();

    await _preferences?.setBool("isDark", isDark);
  }

  Future<bool?> isDarkMode() async {
    await _init();

    return _preferences?.getBool("isDark");
  }

  Future<void> markOnboardingDone() async {
    await _init();

    await _preferences?.setBool("onboarding", true);
  }

  Future<bool?> isOnboardingDone()  async {
    await _init();

    return _preferences?.getBool("onboarding");
  }
}
