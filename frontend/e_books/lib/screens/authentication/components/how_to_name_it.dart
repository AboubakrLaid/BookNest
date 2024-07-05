import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class HowToNameIt extends StatelessWidget {
  const HowToNameIt({super.key, required this.question, required this.action, required this.route});
  final String question;
  final String action;
  final String route;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(
            color: const Color(0xffffffff),
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextButton(
          onPressed: () {
            
            context.pushReplacementNamed(route);
            
          },
          child: Text(
            action,
            style: TextStyle(
              color: const Color(0xffffffff),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
