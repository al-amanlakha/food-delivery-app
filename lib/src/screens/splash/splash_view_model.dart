import 'dart:async';

import 'package:get/get.dart';

import '../welcome/welcome_view.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashTimer();
  }

  void splashTimer() {
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(WelcomeView.id);
    });
  }
}