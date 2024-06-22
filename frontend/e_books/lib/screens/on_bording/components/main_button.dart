import 'package:e_books/screens/on_bording/on_bording_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBordingProvider>(
      builder: (context, state, child) {
        return GestureDetector(
          onTap: () => state.onMainButtonClicked(context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 92.w),
            decoration: BoxDecoration(
              color: state.currentPage == 2
                  ? context.theme.primaryColor
                  : const Color(0x00000000),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 22.sp,
                color: state.currentPage == 2
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF777777),
                fontWeight: FontWeight.w600,
              ),
              child: Text(state.buttonText),
            ),
          ),
        );
      },
    );
  }
}
