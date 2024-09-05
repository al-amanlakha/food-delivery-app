import 'package:flutter/cupertino.dart';

import 'app_values.dart';

abstract class AppPaddings {
  static EdgeInsets defaultPaddingAll = const EdgeInsets.all(AppValues.defaultPadding,);
  static EdgeInsets defaultPaddingHorizontal = const EdgeInsets.symmetric(horizontal: AppValues.defaultPadding,);
  static EdgeInsets defaultPaddingVertical = const EdgeInsets.symmetric(vertical: AppValues.defaultPadding,);
}