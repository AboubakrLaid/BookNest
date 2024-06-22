import 'package:e_books/screens/authntication/sign_up/sign_up.dart';
import 'package:e_books/screens/on_bording/on_bording.dart';
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
  ],
);
