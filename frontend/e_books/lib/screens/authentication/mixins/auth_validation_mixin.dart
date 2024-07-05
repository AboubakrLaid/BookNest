mixin AuthValidationMixin {
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validateEmail(String? email) {
    final emailRegex = RegExp(r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}");
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty.';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format.';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!password.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number';
    } else if (!password.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one uppercase letter';
    } else if (!password.contains(RegExp(r'[a-z]'))){
      return 'Password must contain at least one lowercase letter';
    } else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateConfirmPassword({required String password, required String? confirmPassword}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    } else if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
