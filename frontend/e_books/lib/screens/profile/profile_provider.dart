// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:e_books/models/category.dart';
import 'package:e_books/screens/profile/profile_service.dart';
import 'package:e_books/services/categories_service.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/util/global_variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_books/screens/profile/mixins/profile_mixin.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier with ProfileMixin {
  final ProfileService _profileService = ProfileService();
  final CategoriesService _categoryService = CategoriesService();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  File? image;

  Set<Category> selectedGenres = {};

  bool isFormValid = false;

  bool isCompletingRegistration = false;

  void validateForm() {
    isFormValid = formKey.currentState!.validate();
    notifyListeners();
  }

  String? firstNameValidator() {
    return validateFirstName(firstNameController.text.trim());
  }

  String? lastNameValidator() {
    return validateLastName(lastNameController.text.trim());
  }

  Future<bool?> pickImage({required ImageSource source}) async {
    image = null;
    notifyListeners();
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        notifyListeners();
        logger.i("image picked successfully");
        return true;
      }
      logger.i("image not picked");
      notifyListeners();
      return false;
    } catch (e) {
      logger.e("exception when picking image: $e");
      return null;
    }
  }

  Future<List<Category>?> getCategories() async {
    final response = await _categoryService.getCategories();
    if (response != null) {
      // throw Exception("error fetching categories");
      final List<Category> categories = response["categories"]
          .map<Category>((category) => Category.fromJson(category))
          .toList();
      logger.i("categories fetched successfully");

      return categories;
    } else {
      logger.e("failed to fetch categories");
      return null;
    }
  }

  Future<List<String>?> completeRegistration(BuildContext context) async {
    isCompletingRegistration = true;
    notifyListeners();
    final response = await _profileService.completeProfile(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      image: image!,
      favoriteCategories: selectedGenres.map((e) => e.id).toList(),
    );
    isCompletingRegistration = false;
    notifyListeners();
    final List<String> messages = [];
    if (response != null) {
      if (response.containsKey('no-internet') &&
          response["no-internet"] == true) {
        return [response["message"]];
      } else if (response["success"] = true) {
        context.pushReplacementNamed("Home");
      } else if (response["success"] = false) {
        for (var key in response["errors"].keys) {
          messages.add("$key : ${response["errors"][key]["message"]}");
        }
        return messages;
      }
    }
    return ["Something went wrong"];
  }

  void toggleGenre(Category genre) {
    if (!selectedGenres.contains(genre)) {
      selectedGenres.add(genre);
    } else {
      selectedGenres.remove(genre);
    }
    notifyListeners();
  }

  bool isGenreSelected(Category genre) {
    return selectedGenres.contains(genre);
  }

  void disposeControllers(){
    firstNameController.dispose();
    lastNameController.dispose();
  }
}
