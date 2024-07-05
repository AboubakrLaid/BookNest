import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_books/screens/authentication/components/how_to_name_it.dart';
import 'package:e_books/screens/forget_password/components/custom_pin_put.dart';
import 'package:e_books/screens/forget_password/components/forget_password_button.dart';
import 'package:e_books/screens/forget_password/components/forget_password_text_field.dart';
import 'package:e_books/screens/forget_password/components/verify_code_button.dart';
import 'package:e_books/screens/forget_password/forget_password_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/book_nest_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';

class ForgetPassowrdCodePage extends StatelessWidget {
  const ForgetPassowrdCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ForgetPasswordProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 50.0.w,
              right: 50.0.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: BookNestLogo()),
                Gap(120.h),
                Column(
                  children: [
                    FittedBox(
                      child: Text.rich(
                        TextSpan(
                          text: "Enter the code sent to this email\n",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: state.email,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(30),
                    const CustomPinPut(),
                    const Gap(25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: const VerifyCodeButton(),
                    ),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                            color: const Color(0xffffffff),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(
                            "Go back",
                            style: TextStyle(
                              color: const Color(0xffffffff),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
