import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../data/model/mobile/phone_model.dart';
import '../otp_auth/otp_auth_view.dart';

class MobileAuthViewModel extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  String mobileNumber = "";

  void onChanged(String val) {
    mobileNumber = val;
    update();
  }

  void onGetOtp() {
    if (mobileController.text.isEmpty) return;
    Get.offNamed(
      OtpAuthView.id,
      arguments: PhoneModel(
        dialCode: AppStrings.ukDialCode,
        phoneNumber: mobileController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
}
