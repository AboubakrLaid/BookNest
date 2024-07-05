import 'package:e_books/screens/authentication/sign_up/sign_up_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    super.key,
    this.icon,
    required this.hintText,
    required this.controller,
  });
  final IconData? icon;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, state, child) => TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: false,
        cursorColor: AppThemeProvider.darkTheme.primaryColor,
        obscuringCharacter: "*",
        obscureText: hintText == "Password"
            ? !state.isEyeOpenPassword
            : hintText == "Confirm Password"
                ? !state.isEyeOpenConfirmPassword
                : false,
        keyboardType: hintText == "Username"
            ? TextInputType.name
            : TextInputType.emailAddress,
        // textInputAction:hintText == "Confirm Password" ? TextInputAction.send: TextInputAction.next,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff000000).withOpacity(0.61),
        ),
        // //
        validator: (value) {
          switch (hintText) {
            case "Username":
              return state.usernameValidator(value);
            case "Email":
              return state.emailValidator(value);
            case "Password":
              return state.passwordValidator(value);
            case "Confirm Password":
              return state.confirmPasswordValidator(value);
            default:
              return null;
          }
        },
        // //
        onChanged: (value) async {
          if (hintText == "Username") {
            await state.checkUsernameUniqueness(); // Await the async function
            // state.checkFormValidiy();
          }
          state.checkFormValidiy();
          if (hintText == "Email") {
            state.resetIsEmailUsed();
          }
        },

        // //
        decoration: InputDecoration(
          errorText: hintText == "Username"
              ? state.isUsernameUsed
                  ? state.usernameUsed
                  : null
              : hintText == "Email"
                  ? state.isEmailUsed
                      ? state.emailUsed
                      : null
                  : null,
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
            right: 12.w,
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
          suffixIcon: SizedBox(
            width: 20.w,
            height: 16.h,
            child: hintText == "Password" || hintText == "Confirm Password"
                ? IconButton(
                    onPressed: () {
                      if (hintText == "Password") {
                        state.toggleIsEyeOpenPassword();
                      } else {
                        state.toggleIsEyeOpenConfirmPassword();
                      }
                    },
                    icon: Icon(
                      hintText == "Password"
                          ? state.isEyeOpenPassword
                              ? Icons.visibility
                              : Icons.visibility_off
                          : state.isEyeOpenConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                    ),
                  )
                : Icon(
                    icon,
                  ),
          ),
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
