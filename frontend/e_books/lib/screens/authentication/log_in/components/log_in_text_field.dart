import 'package:e_books/screens/authentication/log_in/log_in_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class LogInTextField extends StatelessWidget {
  const LogInTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInProvider>(
      builder: (context, state, child) => TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: false,
        cursorColor: AppThemeProvider.darkTheme.primaryColor,
        obscuringCharacter: "*",
        obscureText: hintText == "Password" ? !state.isEyeOpenPassword : false,
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
        // //
        validator: (value) {
          switch (hintText) {
            case "Username":
              return state.usernameValidator();

            case "Password":
              return state.passwordValidator();

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
            right: 20.w,
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
            height: 16.h,
            width: 20.w,
            child: hintText == "Password"
                ? IconButton(
                    onPressed: () {
                      if (hintText == "Password") {
                        state.toggleIsEyeOpenPassword();
                      }
                    },
                    icon: Icon(
                      state.isEyeOpenPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                : Icon(icon),
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
