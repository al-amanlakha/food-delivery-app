import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_strings.dart';
import '../../constants/app_values.dart';
import '../../data/model/address/address_model.dart';
import '../../data/preference/preference_manager.dart';
import '../../widgets/dialogs/order_confirmed_dialog.dart';
import '../profile_sub_screens/address_book/edit_address/edit_address_view.dart';
import '../profile_sub_screens/address_book/edit_address/edit_address_view_model.dart';

class CheckoutViewModel extends GetxController {
  final PreferenceManager _preference =
      Get.find(tag: (PreferenceManager).toString());

  late final AddressModel userAddress;

  List<String> addresses = [];
  List<String> timings = [
    "10 AM - 11 AM",
    "11 AM - 12 PM",
    "12 PM - 1 PM",
    "1 PM - 2 PM",
    "2 PM - 3 PM",
    "3 PM - 4 PM",
    "4 PM - 5 PM",
    "5 PM - 6 PM",
    "6 PM - 7 PM",
    "7 PM - 8 PM",
  ];
  List<String> paymentMethods = [
    AppStrings.masterCard,
  ];

  String? selectedAddress;
  String selectedTime = "6 PM - 7 PM";
  String selectedPaymentMethod = AppStrings.masterCard;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  void getLocation() async {
    AddressModel? userAddress = await _preference.getUserAddress();
    if (userAddress != null) {
      addresses.add(userAddress.completeAddress!);
      if (addresses.isNotEmpty) {
        this.userAddress = userAddress;
        selectedAddress = addresses.first;
        update();
      }
    }
  }

  void selectAddress(String address) {
    selectedAddress = address;
    update();
  }

  void selectTime(String time) {
    selectedTime = time;
    update();
  }

  void selectPaymentMethod(String paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    update();
  }

  void onChange() async {
    final result = await Get.to(
      () => const EditAddressView(
        title: AppStrings.editAddress,
      ),
      arguments: userAddress,
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => EditAddressViewModel(),
          fenix: true,
        ),
      ),
    );
    if (result != null) {
      final updatedAddress = result as AddressModel;
      addresses.clear();
      addresses.add(updatedAddress.completeAddress!);
      update();
    }
  }

  void onMakePayment() {
    Get.dialog(
      OrderConfirmedDialog(
        orderId: const Uuid().v1(),
      ),
    );
  }
}
