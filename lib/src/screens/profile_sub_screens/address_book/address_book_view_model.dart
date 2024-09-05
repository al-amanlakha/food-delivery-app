import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../constants/app_strings.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/address/address_model.dart';
import '../../../data/preference/preference_manager.dart';
import 'edit_address/edit_address_view.dart';
import 'edit_address/edit_address_view_model.dart';

class AddressBookViewModel extends GetxController {
  final PreferenceManager _preference =
      Get.find(tag: (PreferenceManager).toString());

  AddressModel? userAddress;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  void getLocation() async {
    AddressModel? userAddress = await _preference.getUserAddress();
    if (userAddress != null) {
      this.userAddress = userAddress;
      update();
    }
  }

  void onEditTap() async {
    var result = await Get.to(
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
      userAddress = updatedAddress;
      update();
    }
  }

  void onAddNewAddress() async {
    final result = await Get.to(
      () => const EditAddressView(
        title: AppStrings.addNewAddresses,
      ),
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
  }
}
