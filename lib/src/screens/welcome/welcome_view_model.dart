import 'package:food_delivery/src/screens/auth/login/login_view.dart';
import 'package:food_delivery/src/screens/auth/signup/signup_view.dart';
import 'package:get/get.dart';

class WelcomeViewModel extends GetxController {
  void onLogin() {
    Get.toNamed(
      LoginView.id,
    );
  }

  void onSignup() {
    Get.toNamed(
      SignupView.id,
    );
  }
}
