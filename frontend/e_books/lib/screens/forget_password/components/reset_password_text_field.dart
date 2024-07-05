import 'package:e_books/screens/authentication/sign_up/sign_up_provider.dart';
import 'package:e_books/screens/forget_password/forget_password_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class ResetPasswordTextField extends StatelessWidget {
  const ResetPasswordTextField({
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
    return Consumer<ForgetPasswordProvider>(
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
      
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff000000).withOpacity(0.61),
        ),
        // //
        validator: (value) {
          switch (hintText) {
           
            case "Password":
              return state.passwordValidator();
            case "Confirm Password":
              return state.confirmPasswordValidator();
            default:
              return null;
          }
        },
        // //
        onChanged: (value) =>state.validatePasswordForm(),

        // //
        decoration: InputDecoration(
          
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
