// ignore_for_file: use_build_context_synchronously

import 'package:e_books/screens/forget_password/forget_password_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/custom_circular_indicator.dart';
import 'package:e_books/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordProvider>(
      builder: (context, state, child) => AbsorbPointer(
        absorbing: !state.isPasswordValide && state.isCheckingPassword,
        child: ElevatedButton(
          onPressed: () async {
            final List<String>? messages = await state.resetPassword();
            if (messages == null) {
              context.pushReplacementNamed("LogIn");
            }
            showCustomSnackBar(
              context,
              content: getContent(messages!),
              backgroundColor: const Color(0xFFF44336),
            );
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 50.h),
            minimumSize: Size(125.w, 50.h),
            backgroundColor: AppThemeProvider.darkTheme.primaryColor
                .withOpacity(state.isPasswordValide ? 1.0 : 0.5),
            // padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 5.h),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: state.isCheckingPassword
              ? CustomCircularIndicator(dimension: 30.dm, color: Colors.white)
              : Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF)
                        .withOpacity(state.isEmailValide ? 1.0 : 0.5),
                  ),
                ),
        ),
      ),
    );
  }
}

Widget getContent(List<String> messages) {
  return Column(
    children: messages
        .map(
          (msg) => Text(
            msg,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        )
        .toList(),
  );
}
