import 'package:flutter/material.dart';
import 'package:food_delivery/src/data/firebase/firestore_service.dart';
import 'package:food_delivery/src/screens/dashboard/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geoCode;
import 'dart:async';

import '../../../constants/app_strings.dart';
import '../../../data/firebase/auth_service.dart';
import '../../../data/model/address/address_model.dart';
import '../../../data/model/location/user_location.dart';
import '../../../data/model/profile/user_model.dart';
import '../../../data/preference/preference_manager.dart';
import '../../../utils/utils.dart';

class LoginViewModel extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final PreferenceManager _preference =
      Get.find(tag: (PreferenceManager).toString());
  AddressModel? addressModel;


  bool isPasswordVisible = false;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<void> validateAndSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        UserCredential userCredential = await _authService.signInWithEmail(
            emailController.text.trim(), passwordController.text.trim());
        bool onboardingShown = await _preference.isOnboardingShown();
        setLoading(false);
        if (onboardingShown) {
          Get.offAllNamed(
            DashboardView.id,
          );
        } else {
          Get.offNamed(OnBoardingView.id);
        }
      } on FirebaseAuthException catch (e) {
        setLoading(false);
        _showToast(e.message ?? 'An unknown error occurred');
      } on TimeoutException catch (_) {
        setLoading(false);
        _showToast('Request Timeout');
      } catch (e) {
        setLoading(false);
        _showToast('An unexpected error occurred: ${e.toString()}');
      }
    } else {
      _showToast('Please check your information and try again.');
    }
  }

  // Method to handle Google Sign-In
  Future<void> signInWithGoogle() async {
    setLoading(true);
    try {
      UserCredential userCredential = await _authService.signInWithGoogle();
      User? user = userCredential.user;

      if (user != null) {
        // Check if user already exists in Firestore
        var existingUser =
            await _firestoreService.getDocument('users', user.uid);
        UserModel userModel;

        if (existingUser == null) {
          await onAllowAccessToLocation();
          userModel = UserModel(
            id: user.uid,
            fullName: user.displayName ?? "",
            email: user.email ?? "",
            emailVerified: user.emailVerified,
            phoneNumber: user.phoneNumber,
            dialCode: AppStrings.ukDialCode,
            addresses: [addressModel ?? AddressModel()],
            dateJoined: DateTime.now(),
            profileImageUrl: user.photoURL,
            firstName: NameUtility.getFirstName(
                  user.displayName,
                ) ??
                "",
            lastName: NameUtility.getLastName(
                  user.displayName,
                ) ??
                "",
          );
          await _firestoreService.addDocument('users', userModel.toJson(),
              documentId: user.uid);
        } else {
          // User exists, deserialize existing data
          userModel = UserModel.fromJson(existingUser);
        }

        // Check if onboarding has been shown
        bool onboardingShown = await _preference.isOnboardingShown();
        setLoading(false);

        if (onboardingShown) {
          Get.offAllNamed(DashboardView.id, arguments: userModel);
        } else {
          Get.offNamed(OnBoardingView.id, arguments: userModel);
        }
      } else {
        setLoading(false);
        _showToast("Failed to retrieve user details from Google.");
      }
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      _showToast(e.message ?? 'Failed to sign in with Google');
    } catch (e) {
      setLoading(false);
      _showToast('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> onAllowAccessToLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionLocation;
    LocationData locData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionLocation = await location.hasPermission();
    if (permissionLocation == PermissionStatus.denied) {
      permissionLocation = await location.requestPermission();
      if (permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    locData = await location.getLocation();

    UserLocation userLocation = UserLocation(
      lat: locData.latitude,
      long: locData.longitude,
    );

    var placeMark = await geoCode.placemarkFromCoordinates(
      locData.latitude!,
      locData.longitude!,
    );
    addressModel = AddressModel.fromPlacemark(placeMark[0]);

    _preference.setUserLocation(userLocation: userLocation);
    if (addressModel != null) {
      _preference.setUserAddress(addressModel!);
    }
    update();
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
