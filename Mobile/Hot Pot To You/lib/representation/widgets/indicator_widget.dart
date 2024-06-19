import 'package:flutter/material.dart';
import '../../core/constants/color_constants.dart';

Widget buildIndicator(bool isActive, Size size) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.bounceInOut,
    margin: const EdgeInsets.symmetric(horizontal: 10), 
    width: isActive ? 20 : 10,
    decoration: BoxDecoration(
      color: isActive ? ColorPalette.primaryColor : ColorPalette.textHide,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
