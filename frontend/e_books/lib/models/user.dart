import 'dart:io';

import 'package:e_books/models/category.dart';
import 'package:e_books/models/token.dart';

class User {
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _userName;
  File? _image;
  List<Category>? _favoriteCategories;
  Token? token;

  User._();
  static final User _instance = User._();

  factory User() {
    return _instance;
  }

  factory User.register({required String email, required String username}) {
    assert(
      _instance._email == null && _instance.username == null,
      "Already registered",
    );
    _instance._email = email;
    _instance._userName = username;

    return _instance;
  }

  factory User.createProfile({
    required File image,
    required String firstName,
    required String lastName,
    required List<Category> categories,
  }) {
    assert(
      _instance._firstName == null &&
          _instance._lastName == null &&
          _instance._image == null &&
          _instance._favoriteCategories == null,
      "Profile Already exist",
    );

    _instance._firstName = firstName;
    _instance._lastName = lastName;
    _instance._image = image;
    _instance._favoriteCategories = categories;

    return _instance;
  }

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get username => _userName;
  File? get image => _image;
  List<Category>? get favoriteCategories => _favoriteCategories;

  // set setId(int id) => _id = id;
  // set setFirstName(String firstName) => _firstName = firstName;
  // set setLastName(String lastName) => _lastName = lastName;
  // set setEmail(String email) => _email = email;
  // set setUserName(String username) => _userName = username;
  // set setImage(File image) => _image = image;
  // set setFavoriteCategories(List<Category> favoriteCategories) =>
  //     _favoriteCategories = favoriteCategories;

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "firstName": _firstName,
      "lastName": _lastName,
      "email": _email,
      "username": _userName,
      "image": _image,
      "favoriteCategories": Category.toMapList(_favoriteCategories),
      "token": token?.value,
    };
  }
}
