// ignore_for_file: use_build_context_synchronously

import 'package:e_books/screens/authentication/sign_up/sign_up_service.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/screens/authentication/mixins/auth_validation_mixin.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';

class SignUpProvider extends ChangeNotifier with AuthValidationMixin {
  final SignUpService _signUpService = SignUpService();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEyeOpenConfirmPassword = false;
  bool isEyeOpenPassword = false;

  bool isSigningUp = false;

  bool isUsernameUsed = false;
  String usernameUsed = "username is already used";

  bool isEmailUsed = false;
  String emailUsed = "email is already used";

  bool isFormValid = false;

  void checkFormValidiy() {
    isFormValid = formKey.currentState!.validate();

    notifyListeners();
  }

  Future<void> checkUsernameUniqueness() async {
    isUsernameUsed = await _signUpService
        .checkUsernameUniqueness(userNameController.text.trim());
    notifyListeners();
  }

  Future<List<String>?> signUp(BuildContext context) async {
    isSigningUp = true;
    notifyListeners();

    final String username = userNameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final Map<String, dynamic>? response = await _signUpService.signUp(
      username: username,
      email: email,
      password: password,
    );
    isSigningUp = false;
    notifyListeners();
    if (response != null) {
      if (response.containsKey('no-internet') && response["no-internet"] == true) {
        return [response["message"]];
      } else if (response["success"] == true) {
        User.register(username: username, email: email);
        context.pushReplacementNamed("LogIn");
        return null;
      }
      List<String> messages = [];
      for (var key in response.keys) {
        if (key == "email") {
          isEmailUsed = true;
          emailUsed = response[key]["message"];
        } else if (key == "username") {
          isUsernameUsed = true;
          usernameUsed = response[key]["message"];
        } else {
          messages.add("$key : ${response[key]['message']}");
        }
      }
      notifyListeners();

      return messages;
    }

    return null;
  }

  void resetIsEmailUsed() {
    isEmailUsed = false;
    notifyListeners();
  }

  void toggleIsUsernameUsed() {
    isUsernameUsed = !isUsernameUsed;
    notifyListeners();
  }

  void toggleIsEyeOpenPassword() {
    isEyeOpenPassword = !isEyeOpenPassword;
    notifyListeners();
  }

  void toggleIsEyeOpenConfirmPassword() {
    isEyeOpenConfirmPassword = !isEyeOpenConfirmPassword;
    notifyListeners();
  }

  String? usernameValidator(String? value) {
    return validateUsername(value);
  }

  String? emailValidator(String? value) {
    return validateEmail(value);
  }

  String? passwordValidator(String? value) {
    return validatePassword(value);
  }

  String? confirmPasswordValidator(String? value) {
    return validateConfirmPassword(
        password: passwordController.text, confirmPassword: value);
  }

  void disposeControllers(){
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
