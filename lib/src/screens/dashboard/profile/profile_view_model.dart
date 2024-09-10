import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_values.dart';
import '../../../data/firebase/auth_service.dart';
import '../../../data/firebase/firestore_service.dart';
import '../../../data/model/profile/user_model.dart';
import '../../../data/model/profile/user_profile_model.dart';
import '../../../widgets/dialogs/confirm_action_dialog.dart';
import '../../profile_sub_screens/address_book/address_book_view.dart';
import '../../profile_sub_screens/address_book/address_book_view_model.dart';
import '../../profile_sub_screens/help/help_view.dart';
import '../../profile_sub_screens/help/help_view_model.dart';
import '../../profile_sub_screens/my_orders/my_orders_view.dart';
import '../../profile_sub_screens/my_orders/my_orders_view_model.dart';
import '../../profile_sub_screens/my_profile/my_profile_view.dart';
import '../../profile_sub_screens/my_profile/my_profile_view_model.dart';
import '../../profile_sub_screens/notification_settings/notification_settings_view.dart';
import '../../profile_sub_screens/notification_settings/notification_settings_view_model.dart';
import '../../profile_sub_screens/payment_methods/payment_methods_view.dart';
import '../../profile_sub_screens/payment_methods/payment_methods_view_model.dart';
import '../../profile_sub_screens/preferences/preferences_view.dart';
import '../../profile_sub_screens/preferences/preferences_view_model.dart';
import '../../welcome/welcome_view.dart';

class ProfileViewModel extends GetxController {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;
  UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserProfile();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<void> fetchCurrentUserProfile() async {
    setLoading(true);
    User? user = auth.currentUser;
    if (user != null) {
      var userData = await _firestoreService.getDocument('users', user.uid);
      if (userData != null) {
        userModel = UserModel.fromJson(userData);
      } else {
        // Handle the scenario when the user profile is not found
        userModel = UserModel(
          id: user.uid,
          fullName: "Default User",
          email: user.email ?? "",
          emailVerified: user.emailVerified,
          dateJoined: DateTime.now(),
          // Populate other default values as needed
        );
      }
    }
    setLoading(false);
  }

  void onMyProfileTap() async {
    final result = await Get.to(
      () => const MyProfileView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      arguments: userModel,
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => MyProfileViewModel(),
          fenix: true,
        ),
      ),
    );
    if (result != null) {
      userModel = result;
      update();
    }
  }

  void onAddressBookTap() {
    Get.to(
      () => const AddressBookView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => AddressBookViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void onPaymentMethodsTap() {
    Get.to(
      () => const PaymentMethodsView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => PaymentMethodsViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void onMyOrdersTap() {
    Get.to(
      () => const MyOrdersView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => MyOrdersViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void onPreferencesTap() {
    Get.to(
      () => const PreferencesView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => PreferencesViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void onNotificationSettingsTap() {
    Get.to(
      () => const NotificationSettingsView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => NotificationSettingsViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void onHelpAndFAQTap() {
    Get.to(
      () => const HelpView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => HelpViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void onLogoutTap() {
    Get.dialog(
      ConfirmActionDialog(
        title: AppStrings.logout,
        message: "Are you sure you want to logout from the app? ",
        onConfirm: () async {
          setLoading(true);
          await _authService.signOut();
          Get.offAllNamed(WelcomeView.id);
          setLoading(false);
        },
      ),
    );
  }
}
