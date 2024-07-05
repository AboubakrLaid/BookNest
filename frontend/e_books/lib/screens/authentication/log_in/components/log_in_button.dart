// ignore_for_file: use_build_context_synchronously

import 'package:e_books/screens/authentication/log_in/log_in_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/custom_snack_bar.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInProvider>(
      builder: (context, state, child) => AbsorbPointer(
        absorbing: !state.isFormValid,
        child: ElevatedButton(
          onPressed: () async {
            final String? message = await state.logIn(context);
            if (message != null) {
                showCustomSnackBar(
                  context,
                  content: Text(message, style:  TextStyle(fontSize: 14.sp, color: const Color(0xFFFFFFFF))),
                  backgroundColor: const Color(0xFFF44336),
                  
                );
            }
          },
          style: ElevatedButton.styleFrom(
            // fixedSize: Size(double.maxFinite, 50.h),
            // minimumSize: Size(258, 50.h),
            maximumSize: const Size(258, 50),
            backgroundColor: AppThemeProvider.darkTheme.primaryColor
                .withOpacity(
                    state.isFormValid ? 1.0 : 0.5),
            // padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 110.w, vertical: 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: state.isLogingIn
              ? CustomCircularIndicator(dimension: 30.dm, color: Colors.white)
              : Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF).withOpacity(
                        state.isFormValid ? 1.0 : 0.5),
                  ),
                ),
        ),
      ),
    );
  }
}
