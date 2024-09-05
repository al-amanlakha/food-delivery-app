import 'package:flutter/material.dart';
import 'package:food_delivery/src/data/model/address/address_model.dart';
import 'package:food_delivery/src/screens/auth/otp_auth/otp_auth_view.dart';
import 'package:food_delivery/src/screens/profile_sub_screens/address_book/add_address/add_address_view.dart';
import 'package:food_delivery/src/screens/profile_sub_screens/address_book/add_address/add_address_view_model.dart';
import 'package:food_delivery/src/screens/profile_sub_screens/address_book/edit_address/edit_address_view.dart';
import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/profile/user_profile_model.dart';
import '../../profile_sub_screens/address_book/edit_address/edit_address_view_model.dart';

class SignupViewModel extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  AddressModel? address;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    update();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void onAddressTap() async {
    final result = await Get.to(
      () => const AddAddressView(
        title: AppStrings.addNewAddresses,
      ),
      curve: Curves.ease,
      arguments: address,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => AddAddressViewModel(),
          fenix: true,
        ),
      ),
    );

    if(result != null) {
      address = result as AddressModel;
      addressController.text = address!.completeAddress!;
      update();
    }
  }

  void validateAndSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      // If the form is valid, create the UserProfileModel and print the data
      const String dialCode = AppStrings.ukDialCode; // Assuming UK Dial Code

      final UserProfileModel userProfile = UserProfileModel(
        userName: nameController.text.trim(),
        userEmail: emailController.text.trim(),
        dialCode: dialCode,
        phoneNumber: mobileController.text.trim(),
      );

      print('User Profile Data:');
      print('Name: ${userProfile.userName}');
      print('Email: ${userProfile.userEmail}');
      print('Email: ${userProfile.dialCode}');
      print('Phone Number: ${userProfile.phoneNumber}');

      // Pass the profile model to the next page or wherever necessary
      Get.toNamed(OtpAuthView.id, arguments: userProfile);
    } else {
      // Validation failed
      print('Form validation failed.');
    }
  }
}
