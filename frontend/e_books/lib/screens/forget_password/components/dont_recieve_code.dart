import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class DontRecieveCode extends StatelessWidget {
  const DontRecieveCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Don’t receive the code?",
          style: TextStyle(
            color: const Color(0xffffffff),
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Resend",
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
