import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/src/data/model/profile/user_profile_model.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view.dart';
import 'package:food_delivery/src/screens/welcome/welcome_view.dart';
import 'package:get/get.dart';

class OtpAuthViewModel extends GetxController {
  final TextEditingController otpController = TextEditingController();
  late UserProfileModel phoneModel;
  Timer? _timer;
  int seconds = 60;

  String otpCode = "";

  @override
  void onInit() {
    updatePhoneModel();
    startTimer();
    super.onInit();
  }

  void startTimer({int? time}) {
    if (time != null) {
      seconds = time;
      update();
    }
    _timer?.cancel(); // cancel any previous running timers
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  void onCompleted(String value) {
    if (value.isEmpty) return;
    otpCode = value;
    update();
  }

  void onContinue() {
    if (otpController.text.isEmpty) return;
    debugPrint(otpController.text.trim());
    Get.offNamedUntil(OnBoardingView.id, (route) => route.settings.name == WelcomeView.id,);
  }

  void updatePhoneModel() {
    if (Get.arguments == null) return;
    phoneModel = Get.arguments as UserProfileModel;
    update();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
