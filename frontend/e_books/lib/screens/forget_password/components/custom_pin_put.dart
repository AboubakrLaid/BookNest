import 'package:e_books/screens/forget_password/forget_password_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends StatelessWidget {
  const CustomPinPut({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 41,
      height: 41,
      textStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff000000).withOpacity(0.61),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(15.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: const Color(0xFFEFEEEE),
      border: Border.all(color: context.theme.primaryColor, width: 2.w),
      borderRadius: BorderRadius.circular(15.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Consumer<ForgetPasswordProvider>(
      builder: (context, state, child) => Pinput(
        length: 6,
        controller: state.codeController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        onChanged: (value) => state.validateCodeForm(),
      ),
    );
  }
}
