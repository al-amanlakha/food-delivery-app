import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void validateAndSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      Get.offNamed(OnBoardingView.id);
    } else {
      // Validation failed
    }
  }
}
