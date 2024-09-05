import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/model/address/address_model.dart';
import '../../../../widgets/dialogs/confirm_action_dialog.dart';

class EditAddressViewModel extends GetxController {
  final TextEditingController addressLine1 = TextEditingController();
  final TextEditingController addressLine2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController county = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController postCode = TextEditingController();

  AddressModel? addressModel;
  bool isDataChanged = false;

  @override
  void onInit() {
    super.onInit();
    _loadAddressModel();
    _setupListeners();
  }


  void _setupListeners() {
    addressLine1.addListener(_onDataChanged);
    addressLine2.addListener(_onDataChanged);
    city.addListener(_onDataChanged);
    county.addListener(_onDataChanged);
    country.addListener(_onDataChanged);
    postCode.addListener(_onDataChanged);
  }

  void _loadAddressModel() {
    if (Get.arguments != null) {
      addressModel = Get.arguments as AddressModel; // Cast for type safety
      _updateControllers();
    }
  }

  void _updateControllers() {
    addressLine1.text = addressModel?.addressLine1 ?? "";
    addressLine2.text = addressModel?.addressLine2 ?? "";
    city.text = addressModel?.city ?? "";
    county.text = addressModel?.county ?? "";
    country.text = addressModel?.country ?? "";
    postCode.text = addressModel?.postalCode ?? "";
    isDataChanged = false; // Ensure flag is reset after updates
  }

  void _onDataChanged() {
    // Evaluate if any field is not empty, not all need to be filled
    bool anyFieldEdited = addressLine1.text.isNotEmpty ||
        addressLine2.text.isNotEmpty ||
        city.text.isNotEmpty ||
        county.text.isNotEmpty ||
        country.text.isNotEmpty ||
        postCode.text.isNotEmpty;

    if (anyFieldEdited && !isDataChanged) {
      isDataChanged = true;
      update(); // Trigger update to enable Save button
    }
  }

  void onTapSaveThisAddress() {
    addressModel ??= AddressModel();
    addressModel?.addressLine1 = addressLine1.text;
    addressModel?.addressLine2 = addressLine2.text;
    addressModel?.city = city.text;
    addressModel?.county = county.text;
    addressModel?.country = country.text;
    addressModel?.postalCode = postCode.text;

    addressModel?.completeAddress = addressModel?.generateCompleteAddress();

    // Reset the isDataChanged flag to disable the Save button
    isDataChanged = false;
    update(); // Ensure UI reflects this change immediately
  }

  void onBackTap() {
    if (isDataChanged) {
      _confirmDiscardChanges();
    } else {
      Get.back(
        result: addressModel,
      );
    }
  }

  void _confirmDiscardChanges() {
    Get.dialog(
      ConfirmActionDialog(
        title: "Discard Changes",
        message: "Are you sure you want to discard changes?",
        onConfirm: () => Get.back(),
      ),
    );
  }

  @override
  void dispose() {
    _removeListeners();
    _disposeControllers();
    super.dispose();
  }

  void _removeListeners() {
    addressLine1.removeListener(_onDataChanged);
    addressLine2.removeListener(_onDataChanged);
    city.removeListener(_onDataChanged);
    county.removeListener(_onDataChanged);
    country.removeListener(_onDataChanged);
    postCode.removeListener(_onDataChanged);
  }

  void _disposeControllers() {
    addressLine1.dispose();
    addressLine2.dispose();
    city.dispose();
    county.dispose();
    country.dispose();
    postCode.dispose();
  }
}
