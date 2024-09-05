
import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenHeight => mediaQuery.size.height;
  double get screenWidth => mediaQuery.size.width;
  double get blockSizeHorizontal => screenWidth / 100;
  double get blockSizeVertical => screenHeight / 100;

  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  // Safe area adjustments
  double get safeAreaHorizontal => mediaQuery.padding.left + mediaQuery.padding.right;
  double get safeAreaVertical => mediaQuery.padding.top + mediaQuery.padding.bottom;
  double get safeAreaBottom => mediaQuery.padding.bottom;
  double get safeBlockHorizontal => (screenWidth - safeAreaHorizontal) / 100;
  double get safeBlockVertical => (screenHeight - safeAreaVertical) / 100;
}
