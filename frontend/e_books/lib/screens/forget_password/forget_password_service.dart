import 'package:e_books/api/api.dart';
import 'package:e_books/api/api_request/api_request.dart';

abstract interface class IForgetPasswordService {
  Future<Map<String, dynamic>?> forgetPassword({
    required String email,
  });
  // Future<Map<String, dynamic>?> send_email_code({required String email});
  Future<Map<String, dynamic>?> verifyEmailCode({
    required String email,
    required String verificationCode,
  });
  Future<Map<String, dynamic>?> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });
}

class ForgetPasswordService implements IForgetPasswordService {
  ForgetPasswordService._();
  static final ForgetPasswordService _instance = ForgetPasswordService._();
  factory ForgetPasswordService() => _instance;

  final Api _api = Api(JsonRequestStrategy());

  final String _mainPath = "/account";

  final Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  @override
  Future<Map<String, dynamic>?> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final JsonRequest apiRequest = JsonRequest(
      method: POST,
      path: "$_mainPath/reset_password/",
      headers: _headers,
      body: {
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
      },
    );

    final data = await _api.send(apiRequest: apiRequest);

    if (data != null) {
      data["success"] = data["statusCode"] == 200;
      return data;
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> verifyEmailCode({
    required String email,
    required String verificationCode,
  }) async {
    final JsonRequest apiRequest = JsonRequest(
      method: POST,
      path: "$_mainPath/verify_forgot_password_code/",
      headers: _headers,
      body: {
        "email": email,
        "verification_code": verificationCode,
      }
    );

    final data = await _api.send(apiRequest: apiRequest);

    if (data != null) {
      data["success"] = data["statusCode"] == 200;
      return data;
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> forgetPassword({
    required String email,
  }) async {
    final JsonRequest apiRequest = JsonRequest(
      method: POST,
      path: "$_mainPath/forgot_password/",
      headers: _headers,
      body: {
        "email": email,
      },
    );

    final data = await _api.send(apiRequest: apiRequest);

    if (data != null) {
      data["success"] = data["statusCode"] == 200;
      return data;
    }
    return null;
  }
}
