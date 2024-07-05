import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class BookNestLogo extends StatelessWidget {
  const BookNestLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text.rich(
        TextSpan(
          text: "Book",
          style: TextStyle(
            fontSize: 48.sp,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: "Nest",
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w600,
                color: context.theme.primaryColor,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
