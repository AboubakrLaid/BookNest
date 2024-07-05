import 'package:e_books/screens/forget_password/components/forget_password_button.dart';
import 'package:e_books/screens/forget_password/components/forget_password_text_field.dart';
import 'package:e_books/screens/forget_password/components/reset_password_button.dart';
import 'package:e_books/screens/forget_password/components/reset_password_text_field.dart';
import 'package:e_books/screens/forget_password/forget_password_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/book_nest_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResetPassowrdPage extends StatefulWidget {
  const ResetPassowrdPage({super.key});

  @override
  State<ResetPassowrdPage> createState() => _ResetPassowrdPageState();
}

class _ResetPassowrdPageState extends State<ResetPassowrdPage> {

  @override
  void dispose() {
    final state = Provider.of<ForgetPasswordProvider>(context, listen: false);
    state.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ForgetPasswordProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(backgroundColor: context.theme.scaffoldBackgroundColor),
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
                Form(
                  key: state.passwordFormKey,
                  child: Column(
                    children: [
                      const FittedBox(
                        child: Text(
                          "Enter your new password",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Gap(30),
                      ResetPasswordTextField(
                        hintText: "Password",
                        controller: state.passwordController,
                      ),
                      const Gap(18),
                      ResetPasswordTextField(
                        hintText: "Confirm Password",
                        controller: state.confirmPasswordController,
                      ),
                      const Gap(25),
                      const ResetPasswordButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
