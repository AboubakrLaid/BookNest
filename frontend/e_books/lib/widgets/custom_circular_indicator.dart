import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator(
      {super.key, required this.dimension, required this.color});
  final double dimension;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
