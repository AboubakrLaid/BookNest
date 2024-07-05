// import 'package:e_books/util/export.dart';

import 'dart:async';

import 'package:e_books/api/api_request/api_request.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '../../../api/api.dart';

abstract class ISignUpService {
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  });
}

class SignUpService implements ISignUpService {
  SignUpService._();
  static final SignUpService _instance = SignUpService._();
  factory SignUpService() => _instance;

  final Api _api = Api(JsonRequestStrategy());

  final String _mainPath = "/account";
  final String _applicationJson = "application/json";

  @override
  Future<Map<String, dynamic>?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {

    final JsonRequest apiRequest = JsonRequest(
      method: POST,
      headers: {
        "Content-Type": _applicationJson,
      },
      path: "$_mainPath/register/",
      body: {
        "username": username,
        "email": email,
        "password": password,
      },
    );

    final data = await _api.send(apiRequest: apiRequest);

    return data;
  }

  Future<bool> checkUsernameUniqueness(String username) async {
    bool isUsernameUsed = false;
    Completer<bool> completer = Completer<bool>();
     EasyDebounce.debounce(
      "username",
      const Duration(milliseconds: 700),
      () async {
        Api api = Api(JsonRequestStrategy());

        final Map<String, String> queryParameters = {
          "username": username,
        };

        final JsonRequest apiRequest = JsonRequest(
          method: GET,
          path: "/account/username-uniquness/",
          headers: {
        "Content-Type": _applicationJson,
      },
          queryParameters: queryParameters,
        );
        final data = await api.send(apiRequest: apiRequest);

        isUsernameUsed = data != null ? !data["success"] : false;
        completer.complete(isUsernameUsed);
      },
    );
    return completer.future;
  }
}
