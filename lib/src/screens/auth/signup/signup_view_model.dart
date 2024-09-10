import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:food_delivery/src/data/model/address/address_model.dart';
import 'package:food_delivery/src/screens/auth/otp_auth/otp_auth_view.dart';
import 'package:food_delivery/src/screens/profile_sub_screens/address_book/add_address/add_address_view.dart';
import 'package:food_delivery/src/screens/profile_sub_screens/address_book/add_address/add_address_view_model.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_values.dart';
import '../../../data/firebase/firestore_service.dart';
import '../../../data/model/profile/user_model.dart';
import '../../../data/firebase/auth_service.dart';

class SignupViewModel extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  AddressModel? address;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void setLoading(bool loading) {
    isLoading = loading;
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
          () => Get.lazyPut(() => AddAddressViewModel(), fenix: true)),
    );

    if (result != null) {
      address = result as AddressModel;
      addressController.text = address!.completeAddress!;
      update();
    }
  }

  void validateAndSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      const String dialCode = AppStrings.ukDialCode;

      try {
        setLoading(true);
        UserCredential userCredential = await _authService.signUpWithEmail(
            emailController.text.trim(), passwordController.text.trim());
        final user = userCredential.user;
        final displayName = nameController.text.trim();
        await user!.updateDisplayName(displayName);
        await _authService.signOut();

        UserModel newUser = UserModel(
          id: userCredential.user!.uid,
          fullName: displayName,
          email: emailController.text.trim(),
          phoneNumber: mobileController.text.trim(),
          dialCode: dialCode,
          addresses: [
            address ?? AddressModel(),
          ],
          dateJoined: DateTime.now(),
          firstName: NameUtility.getFirstName(displayName) ?? "",
          lastName: NameUtility.getLastName(displayName) ?? "",
        );
        await _firestoreService.addDocument(
          'users',
          newUser.toJson(),
          documentId: newUser.id,
        );
        await _authService
            .signInWithPhone("${newUser.dialCode}${newUser.phoneNumber}",
                (String verId, int? resendToken) {
          newUser.verificationId = verId;
          setLoading(false);
          Get.offNamed(
            OtpAuthView.id,
            arguments: newUser,
          );
        });
      } on FirebaseAuthException catch (e) {
        setLoading(false);
        _showToast(e.message ?? 'An unknown error occurred during signup');
      } catch (e) {
        setLoading(false);
        _showToast('An unexpected error occurred: ${e.toString()}');
      }
    } else {
      setLoading(false);
      _showToast('Form validation failed.');
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
