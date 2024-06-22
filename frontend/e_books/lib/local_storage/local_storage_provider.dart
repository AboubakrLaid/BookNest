import 'package:flutter/material.dart';
import 'local_storage.dart';

class LocalStorageProvider extends ChangeNotifier {
  final LocalStorage _localStorage = LocalStorage();

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  

  Future<void> clear() async{
    await _localStorage.clear();
  }

  Future<void> setTheme({required bool isDark}) async {
    await _localStorage.setTheme(isDark: isDark);
    super.notifyListeners();
  }

  Future<bool?> isDarkMode() async {
    return await _localStorage.isDarkMode();
  }

  Future<void> markOnboardingDone() async {
    await _localStorage.markOnboardingDone();
  }

  Future<bool?> isOnboardingDone() async {
    return await _localStorage.isOnboardingDone();
  }
}
