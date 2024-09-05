import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color grey = Color(0XFF828282);
  static const Color white = Color(0XFFFFFFFF);
  static const Color orange = Color(0XFFFC6011);
  static const Color warmWhite = Color(0XFFFAFAFA);
  static const Color lightWhite = Color(0XFFF3F0F0);
  static const Color warningRed = Color(0XFFE02222);
  static const Color blackishGrey = Color(0XFF4A4B4D);
  static const Color lightGrey = Color(0XFFB6B7B7);
  static const Color darkGrey = Color(0XFF7C7D7E);
  static const Color gradientColor1 = Color(0XFFFFDEA8);
  static const Color gradientColor2 = Color(0XFFFEC84E);

  static const LinearGradient splashGradient = LinearGradient(
    colors: [
      warningRed,
      orange,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient radialGradient = RadialGradient(
    colors: [
      Color(0XFFFFDEA8),
      Color(0XFFFEC84E),
    ],
    radius: 0.8,
    center: Alignment.center,
    // The point at which the gradient starts
    focal: Alignment.center,
    // Focal point of the gradient
    focalRadius: 0, // The radius around the focal point
  );
}
