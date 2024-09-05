import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app_values.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final currentNavigatorState = navigatorKey.currentState!;
final BuildContext myContext = currentNavigatorState.context;

const SizedBox defaultHeightSpacing = SizedBox(
  height: AppValues.defaultMargin,
);

const SizedBox defaultWidthSpacing = SizedBox(
  width: AppValues.defaultMargin,
);