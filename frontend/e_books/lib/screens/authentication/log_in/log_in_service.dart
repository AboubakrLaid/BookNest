
import 'package:e_books/api/api.dart';
import 'package:e_books/api/api_request/api_request.dart';

abstract class ILogInService {
  Future<Map<String, dynamic>?> logIn(
      {required String username, required String password});
}

class LogInService implements ILogInService {
  LogInService._();
  static final LogInService _instance = LogInService._();
  factory LogInService() => _instance;

  final Api _api = Api(JsonRequestStrategy());

  final String _mainPath = "/account";
  final String _applicationJson = "application/json";

  @override
  Future<Map<String, dynamic>?> logIn({
    required String username,
    required String password,
  }) async {

    final JsonRequest apiRequest = JsonRequest(
      method: POST,
      headers: {
        "Content-Type": _applicationJson,
      },
      path: "$_mainPath/login/",
      body: {
        "username": username,
        "password": password,
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
