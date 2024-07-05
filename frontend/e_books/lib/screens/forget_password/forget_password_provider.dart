import 'package:e_books/screens/authentication/mixins/auth_validation_mixin.dart';
import 'package:e_books/screens/forget_password/forget_password_service.dart';
import 'package:flutter/material.dart';

class ForgetPasswordProvider extends ChangeNotifier with AuthValidationMixin {
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ForgetPasswordService _forgetPasswordService = ForgetPasswordService();

  String email = "";

  bool isCheckingEmail = false;
  bool isCheckingCode = false;
  bool isCheckingPassword = false;

  bool isEmailValide = false;
  bool isCodeValide = false;
  bool isPasswordValide = false;

  bool isEyeOpenPassword = false;
  bool isEyeOpenConfirmPassword = false;

  void toggleIsEyeOpenPassword() {
    isEyeOpenPassword = !isEyeOpenPassword;
    notifyListeners();
  }
  void toggleIsEyeOpenConfirmPassword(){
    isEyeOpenConfirmPassword = ! isEyeOpenConfirmPassword;
    notifyListeners();
  }

  String? emailValidator() {
    return validateEmail(emailController.text.trim());
  }

  String? passwordValidator() {
    return validatePassword(passwordController.text.trim());
  }

  String? confirmPasswordValidator() {
    return validateConfirmPassword(
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );
  }

  void validateEmailForm() {
    isEmailValide = emailFormKey.currentState!.validate();
    notifyListeners();
  }

  void validateCodeForm() {
    isCodeValide = codeController.text.length == 6;
    notifyListeners();
  }

  void validatePasswordForm() {
    isPasswordValide = passwordFormKey.currentState!.validate();
    notifyListeners();
  }

  Future<String?> forgetPassword() async {
    isCheckingEmail = true;
    notifyListeners();
    final temp = emailController.text.trim();

    final data = await _forgetPasswordService.forgetPassword(email: temp);

    isCheckingEmail = false;
    notifyListeners();

    if (data != null) {
      if (data.containsKey('no-internet') && data["no-internet"] == true) {
        return data["message"];
      } else if (data["statusCode"] == 200) {
        final int index = temp.indexOf("@");
        email = "${temp.substring(0, 2)}****${temp.substring(index - 2)}";
        return null;
      } else {
        return data["error"];
      }
    }
    return "Something wentwrong";
  }

  Future<String?> verifyCode() async {
    isCheckingCode = true;
    notifyListeners();

    final data = await _forgetPasswordService.verifyEmailCode(
      email: emailController.text.trim(),
      verificationCode: codeController.text,
    );

    isCheckingCode = false;
    notifyListeners();

    if (data != null) {
      if (data.containsKey('no-internet') && data["no-internet"] == true) {
        return data["message"];
      } else
      if (data["statusCode"] == 200) {
        return null;
      } else {
        // codeController.clear();
        return data["error"];
      }
    }
    return "Something wentwrong";
  }

  Future<List<String>?> resetPassword() async {
    isCheckingPassword = true;
    notifyListeners();

    final data = await _forgetPasswordService.resetPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    isCheckingPassword = false;
    notifyListeners();

    List<String> messages = [];
    if (data != null) {
      if (data.containsKey('no-internet') && data["no-internet"] == true) {
        return data["message"];
      } else if (data["success"] == true){
          return null;
      }else{
        for(var key in data.keys){
          messages.add(data[key]["message"]);

        }
        return messages;
      }
    }
    return ["Something wentwrong"];
  }

  void disposeControllers(){
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
