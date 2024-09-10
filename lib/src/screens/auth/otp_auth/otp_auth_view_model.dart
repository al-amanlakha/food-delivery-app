import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/src/data/model/profile/user_model.dart';
import 'package:food_delivery/src/data/model/profile/user_profile_model.dart';
import 'package:food_delivery/src/screens/auth/login/login_view.dart';
import 'package:food_delivery/src/screens/dashboard/dashboard_view.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view.dart';
import 'package:food_delivery/src/screens/welcome/welcome_view.dart';
import 'package:get/get.dart';

import '../../../data/firebase/auth_service.dart';
import '../../../data/firebase/firestore_service.dart';
import '../../../data/preference/preference_manager.dart';

class OtpAuthViewModel extends GetxController {
  final TextEditingController otpController = TextEditingController();
  late UserModel phoneModel;
  Timer? _timer;
  int seconds = 60;

  bool isLoading = false;

  String otpCode = "";
  bool isError = false;

  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final PreferenceManager _preference =
      Get.find(tag: (PreferenceManager).toString());

  @override
  void onInit() {
    updatePhoneModel();
    startTimer();
    super.onInit();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    update();
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
    verifyPhoneNumberWithSmsCode();
  }

  void verifyPhoneNumberWithSmsCode() async {
    setLoading(true);
    if (phoneModel.verificationId == null) {
      setLoading(false);
      _showToast("Verification ID is null, please request code again.");
      return;
    }

    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: phoneModel.verificationId!,
        smsCode: otpCode,
      );

      // Normally here you would sign in with the credential
      // Instead, just verify the credential validity
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((userCredential) async {
        final user = userCredential.user;
        final displayName = phoneModel.fullName;
        await user!.updateDisplayName(displayName);
        phoneModel.phoneVerified = true;
        _firestoreService.addDocument(
          'users',
          phoneModel.toJson(),
          documentId: phoneModel.id,
        );
        setLoading(false);
        // Optionally navigate to another screen or show success message
        _showToast(
          "Phone number verified successfully!",
          color: Colors.greenAccent,
        );
        await _authService.signOut();
        Get.offAllNamed(LoginView.id);
      }).catchError((error) {
        setLoading(false);
        _showToast("Invalid code entered, please try again.");
      });
    } catch (e) {
      setLoading(false);
      _showToast("Error occurred: ${e.toString()}");
    }
  }

  void updatePhoneModel() {
    if (Get.arguments == null) return;
    phoneModel = Get.arguments as UserModel;
    update();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _showToast(
    String message, {
    Color color = Colors.red,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
