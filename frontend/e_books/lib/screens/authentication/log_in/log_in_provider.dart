// ignore_for_file: use_build_context_synchronously

import 'package:e_books/models/token.dart';
import 'package:e_books/models/user.dart';
import 'package:e_books/screens/authentication/log_in/log_in_service.dart';
import 'package:e_books/screens/authentication/mixins/auth_validation_mixin.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class LogInProvider extends ChangeNotifier with AuthValidationMixin {
  final LogInService _logInService = LogInService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEyeOpenPassword = false;
  bool isFormValid = false;
  bool isLogingIn = false;

  void toggleIsEyeOpenPassword() {
    isEyeOpenPassword = !isEyeOpenPassword;
    notifyListeners();
  }

  String? usernameValidator() {
    return validateUsername(userNameController.text.trim());
  }

  String? passwordValidator() {
    return passwordController.text.trim().isEmpty
        ? "Password is required"
        : null;
  }

  void validateForm() {
    isFormValid = formKey.currentState!.validate();
    notifyListeners();
  }

  Future<String?> logIn(BuildContext context) async {
    isLogingIn = true;
    notifyListeners();
    final String username = userNameController.text.trim();
    final String password = passwordController.text.trim();
    final response = await _logInService.logIn(
      username: username,
      password: password,
    );

    isLogingIn = false;
    notifyListeners();
    if (response != null) {
      if (response.containsKey('no-internet') &&
          response["no-internet"] == true) {
        return response["message"];
      } else if (response["completed_registration"] == true) {
        context.pushReplacementNamed("Home");
      } else if (response["completed_registration"] == false) {
        final Token token = Token(value: response["token"]);
        User user = User();
        user.token = token;
        context.pushReplacementNamed("Profile");
      } else {
        return response["error"];
      }
      // final token = response["token
    }
    return null;
  }

   void disposeControllers(){
    userNameController.dispose();
    passwordController.dispose();
  }
}
