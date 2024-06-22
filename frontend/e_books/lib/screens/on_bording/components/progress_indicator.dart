import 'package:e_books/screens/on_bording/on_bording_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_books/util/export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBordingProvider>(
      builder: (context, state, child)=> SmoothPageIndicator(
        controller: state.pageController,
        count: 3,
        // onDotClicked: (index)=> state.onDotClicked(index),
        effect: ExpandingDotsEffect(
          dotHeight: 8.h,
          dotWidth: 30.w,
          spacing: 6.w,
          radius: 10.r,
          dotColor: const Color(0xFFD9D9D9),
          activeDotColor: context.theme.primaryColor,
        ),
      ),
    );
  }
}