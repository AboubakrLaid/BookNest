import 'package:e_books/screens/authentication/components/how_to_name_it.dart';
import 'package:e_books/screens/authentication/log_in/components/log_in_button.dart';
import 'package:e_books/screens/authentication/log_in/components/log_in_text_field.dart';
import 'package:e_books/screens/authentication/log_in/log_in_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/book_nest_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    final LogInProvider logInProvider =
        Provider.of<LogInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppThemeProvider.darkTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: kHeight,
          child: Padding(
            padding: EdgeInsets.only(
                left: 50.0.w, right: 50.0.w,),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      const BookNestLogo(),
                      Gap(25.h),
                      Text(
                        "Nestled in Stories, One \n Book at a Time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Gap(110.h),
                  Form(
                    key: logInProvider.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp,
                              color: const Color(0xffffffff)),
                        ),
                                    
                         Gap(47.h),
                        LogInTextField(
                          hintText: "Username",
                          controller: logInProvider.userNameController,
                          icon: Icons.person,
                        ),
                             Gap(40.h),       
                        Column(
                          children: [
                            LogInTextField(
                              hintText: "Password",
                              controller: logInProvider.passwordController,
                              icon: Icons.lock,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => context.pushNamed("ForgetPassword"),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: const LoginButton(),
                            ),
                            const HowToNameIt(
                              question: "Don't you have an account",
                              action: "Signup",
                              route: "SignUp",
                            ),
                          ],
                        )
                      ],
                    ),
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
