import 'package:e_books/screens/forget_password/components/forget_password_button.dart';
import 'package:e_books/screens/forget_password/components/forget_password_text_field.dart';
import 'package:e_books/screens/forget_password/forget_password_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/book_nest_logo.dart';
import 'package:flutter/material.dart';

class ForgetPassowrdPage extends StatelessWidget {
  const ForgetPassowrdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ForgetPasswordProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(backgroundColor: context.theme.scaffoldBackgroundColor),
      body: Padding(
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
                const FittedBox(
                  child: Text(
                    "Don’t worry! It happens. Please enter the\n address associated with your account.",
                   maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Gap(30),
                ForgetPasswordTextField(
                  controller: state.emailController,
                  hintText: "email",
                ),
                const Gap(25),
        
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.w),
                  child: const ForgetPasswordButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
