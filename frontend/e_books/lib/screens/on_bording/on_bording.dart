// ignore_for_file: use_build_context_synchronously

import 'package:e_books/screens/on_bording/components/body.dart';
import 'package:e_books/screens/on_bording/components/main_button.dart';
import 'package:e_books/screens/on_bording/components/progress_indicator.dart';
import 'package:e_books/screens/on_bording/on_bording_provider.dart';
import 'package:e_books/screens/on_bording/components/side_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/widgets.dart';


class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> with TickerProviderStateMixin {
  late OnBordingProvider onBordingProvider;
  late PageController pageController = PageController();
 

  @override
  void didChangeDependencies() {
    // We used the didChangeDependencies method in the Onboarding state to access
    //  and initialize the onBordingProvider. This guarantees the provider
    //   is available before build is called.
    super.didChangeDependencies();
    onBordingProvider = Provider.of<OnBordingProvider>(context, listen: false);
    onBordingProvider.init(500, this, pageController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeProvider.darkTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: kHeight,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.05 * kHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gap(kHeight * 0.05),
                FittedBox(
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
                ),
                Text(
                  "Nestled in Stories, One \n Book at a Time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Gap(49.h),
                const OnBordingBody(),
                Consumer<OnBordingProvider>(
                  builder: (context, state, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: ,
                      children: [
                        SideNavigationButton(
                          isHidden: state.currentPage == 0,
                          icon: Icons.arrow_back_ios,
                          onPressed: () => state.onArrowClicked(true),
                        ),
                        const MyProgressIndicator(),
                        SideNavigationButton(
                          isHidden: state.currentPage == 2,
                          icon: Icons.arrow_forward_ios,
                          onPressed: () => state.onArrowClicked(false),
                        ),
                      ],
                    );
                  },
                ),
                Gap(26.h),
                
                Consumer<OnBordingProvider>(
                  builder: (context, OnBordingProvider state, child) {
                    return const MainButton();
                  },
                ),
                // Gap(kHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    onBordingProvider.disposeControllers();
    super.dispose();
  }
}
