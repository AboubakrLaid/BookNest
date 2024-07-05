import "package:e_books/screens/authentication/components/how_to_name_it.dart";
import "package:e_books/screens/authentication/sign_up/components/sign_up_text_field.dart";
import "package:e_books/screens/authentication/sign_up/sign_up_provider.dart";
import "package:e_books/screens/authentication/sign_up/components/sign_up_button.dart";
import "package:e_books/util/export.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../../widgets/book_nest_logo.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // 
  @override
  Widget build(BuildContext context) {
    final SignUpProvider signUpProvider =
        Provider.of<SignUpProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppThemeProvider.darkTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: kHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.0.w,
              // vertical: 0.05 * kHeight,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BookNestLogo(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 55.0.h),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                          color: const Color(0xffffffff)),
                    ),
                  ),
                  Form(
                    key: signUpProvider.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //  Gap(20.h),
                        SignUpTextField(
                          hintText: "Username",
                          controller: signUpProvider.userNameController,
                          icon: Icons.person,
                        ),
                        Gap(42.h),
                        SignUpTextField(
                          hintText: "Email",
                          controller: signUpProvider.emailController,
                          icon: Icons.email,
                        ),
                        Gap(42.h),
                        SignUpTextField(
                          hintText: "Password",
                          controller: signUpProvider.passwordController,
                          icon: Icons.lock,
                        ),
                        Gap(42.h),
                        SignUpTextField(
                          hintText: "Confirm Password",
                          controller: signUpProvider.confirmPasswordController,
                          icon: Icons.lock,
                        ),
                        //  Gap(20.h),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w ,right: 20.w, top: 54.h,),
                    child: const SignUpButton(),
                  ),
                  const HowToNameIt(
                    question: "Already have an account?",
                    action: "Login",
                    route: "LogIn",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
