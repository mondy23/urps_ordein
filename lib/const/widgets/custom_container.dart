import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final height;
  const CustomContainer({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
        color: cardBackgroundColor,
      ),
      child: child
    );
  }
}