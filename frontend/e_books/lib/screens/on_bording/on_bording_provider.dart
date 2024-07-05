// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:e_books/local_storage/local_storage_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

import '../../local_storage/local_storage.dart';

class OnBordingProvider extends ChangeNotifier {
  late PageController pageController;
  late AnimationController animationController;
  double value = 1 / 3;
  int currentPage = 0;
  final String _START = "Start";
  final String _SKIP = "Skip";
  String buttonText = "Skip";

  void init(int duration, TickerProvider vsync, PageController pageController) {
    this.pageController = pageController;
    animationController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: duration),
    );
    animationController.animateTo(value);
    // notifyListeners();
  }

  void onDotClicked(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    notifyListeners();
  }

  void onPageChanged(int index) {
    value = index / 3;
    currentPage = index;
    // pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    _changeButtonText();

    notifyListeners();
    pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void onArrowClicked(bool isLeft) {
    if (isLeft) {
      if (currentPage > 0) {
        currentPage--;
      }
    } else {
      if (currentPage < 2) {
        currentPage++;
      }
    }
    value = currentPage / 3;
    _changeButtonText();
    pageController
        .animateToPage(currentPage,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn)
        .then((value) => notifyListeners());
  }

  void onMainButtonClicked(BuildContext context) async {
    if (buttonText == _START) {
      final LocalStorage localStorage = LocalStorage();

      await localStorage.markOnboardingDone();
      
      context.pushNamed("SignUp");
    } else {
      currentPage = 2;
      _changeButtonText();
      value = 1.0;
      pageController.jumpToPage(currentPage);
    }
  }

  void disposeControllers() {
    pageController.dispose();
    animationController.dispose();
  }

  void _changeButtonText() {
    if (currentPage == 2) {
      buttonText = _START;
    } else {
      buttonText = _SKIP;
    }
  }
}
