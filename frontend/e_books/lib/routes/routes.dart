
import 'package:e_books/screens/authentication/log_in/log_in.dart';
import 'package:e_books/screens/authentication/sign_up/sign_up.dart';
import 'package:e_books/screens/forget_password/pages/forget_password.dart';
import 'package:e_books/screens/forget_password/pages/forget_password_code.dart';
import 'package:e_books/screens/forget_password/pages/reset_password.dart';
import 'package:e_books/screens/home/home.dart';
import 'package:e_books/screens/on_bording/on_bording.dart';
import 'package:e_books/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget defaultScreen = const OnBording();

final router = GoRouter(
  initialLocation: "/",
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: "/",
      name: "OnBording",
      builder: (context, state) => defaultScreen,
    ),
    GoRoute(
      path: "/SignUp",
      name: "SignUp",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SignUp(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/LogIn",
      name: "LogIn",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Login(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/Code",
      name: "Code",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ForgetPassowrdCodePage(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/ResetPassword",
      name: "ResetPassword",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ResetPassowrdPage(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/ForgetPassword",
      name: "ForgetPassword",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ForgetPassowrdPage(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/Profile",
      name: "Profile",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Profile(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/Home",
      name: "Home",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Home(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
          child: child,
        ),
      ),
    ),
  ],
);
