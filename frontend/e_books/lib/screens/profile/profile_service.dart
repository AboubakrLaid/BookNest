// ignore_for_file: unused_field

import 'dart:io';

import 'package:e_books/api/api.dart';
import 'package:e_books/api/api_request/api_request.dart';
import 'package:e_books/models/user.dart';

abstract class IProfileService {
  Future<Map<String, dynamic>?> completeProfile({
    required String firstName,
    required String lastName,
    required File image,
    required List<int> favoriteCategories,
  });
}

class ProfileService implements IProfileService {
  ProfileService._();
  static final _instance = ProfileService._();
  factory ProfileService() => _instance;

  final Api _api = Api(MultipartRequestStrategy());

  final String _mainPath = "/account";
  final String _applicationJson = "application/json";
  final String _multipartFormData = "multipart/form-data";

  @override
  Future<Map<String, dynamic>?> completeProfile({
    required String firstName,
    required String lastName,
    required File image,
    required List<int> favoriteCategories,
  }) async {
    print(User().token?.value);
    final ApiRequest apiRequest = FileRequest(
      method: PUT,
      headers: {
        "Content-Type": _multipartFormData,
        "Authorization": "Bearer ${User().token?.value}"
      },
      path: "$_mainPath/complete_register/",
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "favorite_categories": favoriteCategories,
      },
      filesMap: {
        "profile_image": image,
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
