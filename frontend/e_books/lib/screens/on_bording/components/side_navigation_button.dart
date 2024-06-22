import 'package:e_books/util/export.dart';
import 'package:flutter/material.dart';

class SideNavigationButton extends StatelessWidget {
  final bool isHidden;
  final IconData icon;
  final VoidCallback onPressed;
  const SideNavigationButton(
      {super.key,
      required this.isHidden,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isHidden ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 26.0,
          color: context.theme.primaryColor,
        ),
      ),
    );
  }
}
