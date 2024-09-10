import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/src/data/firebase/auth_service.dart';
import 'package:food_delivery/src/screens/dashboard/dashboard_view.dart';
import 'package:get/get.dart';

import '../welcome/welcome_view.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashTimer();
  }

  void splashTimer() {
    Timer(const Duration(seconds: 3), checkAuthentication);
  }

  void checkAuthentication() {
    // Check if user is logged in
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If the user is logged in, navigate to the HomeView
      Get.offAllNamed(
        DashboardView.id,
      ); // Make sure you have a route set up for HomeView
    } else {
      // If no user is logged in, navigate to the WelcomeView
      Get.offAllNamed(
        WelcomeView.id,
      ); // Make sure you have a route set up for WelcomeView
    }
  }
}
