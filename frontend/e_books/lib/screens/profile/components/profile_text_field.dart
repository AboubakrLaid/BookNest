import 'package:e_books/screens/profile/profile_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, state, child) => TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: false,
        cursorColor: AppThemeProvider.darkTheme.primaryColor,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.name,
        // textInputAction:hintText == "Confirm Password" ? TextInputAction.send: TextInputAction.next,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff000000).withOpacity(0.61),
        ),
        // //
        // //
        validator: (value) {
          switch (hintText) {
            case "First Name":
              return state.firstNameValidator();

            case "Last Name":
              return state.lastNameValidator();

            default:
              return null;
          }
        },
        // //
        onChanged: (value) {
          state.validateForm();
        },
        // //
        decoration: InputDecoration(
          // errorText: hintText == "Username"
          //     ? state.isUsernameUsed
          //         ? state.usernameUsed
          //         : null
          //     : null,
          errorMaxLines: 3,
          errorStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFF44336),
          ),
          // //
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: 24.w,
            top: 12.h,
            bottom: 0,
          ),
          // //
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000).withOpacity(0.61),
          ),
          // //
          suffixIcon: const Icon(Icons.person),

          suffixIconColor: const Color(0xFF212121),
          // //
          filled: true,
          fillColor: const Color(0xFFEFEEEE),
          // //
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          // //
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: AppThemeProvider.darkTheme.primaryColor,
              width: 2.w,
            ),
          ),
          // //
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: const Color(0xFFF44336),
              width: 2.w,
            ),
          ),
          // //
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: const Color(0xFFF44336),
              width: 2.w,
            ),
          ),
        ),
      ),
    );
  }
}
