import 'package:e_books/screens/on_bording/on_bording_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBordingBody extends StatelessWidget {
  const OnBordingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'images/on_bording_pic1.svg',
      'images/on_bording_pic2.svg',
      'images/on_bording_pic3.svg'
    ];
    final List<String> titles = [
      "Discover a World of Books",
      "Engage with Reviews",
      "Personalize Your Reading Experience"
    ];
    final List<String> descriptions = [
      "Welcome to BookNest! Discover your next favorite book from a vast library of titles. Whether you love thrillers, fantasy, or sci-fi, we've got something for every book lover.",
      "Read reviews from fellow book lovers and share your thoughts on your favorite reads. BookNest lets you engage with a community of readers through insightful reviews.",
      "Tailor your reading journey with personalized recommendations, track your favorite categories, and manage your reading list. Your perfect book is just a search away."
    ];
    return Expanded(
      child: Consumer<OnBordingProvider>(builder: (context, state, child) {
        return PageView.builder(
            itemCount: 3,
            controller: state.pageController,
            onPageChanged: (value) => state.onPageChanged(value),
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ss[index],
                  FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset(
                      images[index],
                      width: kWidth,
                  
                      height: 0.3 * kHeight,
                    ),
                  ),
                  // Gap(52.h),
                  FittedBox(
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Gap(24.h),
                  Text(
                    descriptions[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 0.9,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
