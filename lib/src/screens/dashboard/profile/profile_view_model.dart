import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_values.dart';
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
  UserProfileModel userProfileModel = UserProfileModel(
      userName: "Amandeep", phoneNumber: "7448653212");

  void onMyProfileTap() async {
    final result = await Get.to(
      () => const MyProfileView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      arguments: userProfileModel,
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => MyProfileViewModel(),
          fenix: true,
        ),
      ),
    );
    if (result != null) {
      userProfileModel = result;
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
        onConfirm: () {
          Get.offAllNamed(WelcomeView.id);
        },
      ),
    );
  }
}
