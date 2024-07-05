// ignore_for_file: use_build_context_synchronously

import 'package:e_books/screens/authentication/sign_up/sign_up_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/custom_circular_indicator.dart';
import 'package:e_books/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, state, child) => AbsorbPointer(
        absorbing: !state.isFormValid,
        child: ElevatedButton(
          onPressed: () async {
            final List<String>? messages = await state.signUp(context);
            if (messages!=null && messages.isNotEmpty) {
              showCustomSnackBar(
                context,
                backgroundColor: const Color(0xFFF44336),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: messages
                      .map(
                        (message) => Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            message,
                            style:  TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 50.h),
            minimumSize: Size(125.w, 50.h),
            backgroundColor: AppThemeProvider.darkTheme.primaryColor
                .withOpacity(state.isFormValid &&
                        !state.isUsernameUsed &&
                        !state.isEmailUsed
                    ? 1.0
                    : 0.5),
            // padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 5.h),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: state.isSigningUp
              ? CustomCircularIndicator(dimension: 30.dm, color: Colors.white)
              : FittedBox(
                child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF).withOpacity(
                          state.isFormValid &&
                                  !state.isUsernameUsed &&
                                  !state.isEmailUsed
                              ? 1.0
                              : 0.5),
                    ),
                  ),
              ),
        ),
      ),
    );
  }
}
