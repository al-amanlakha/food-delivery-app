import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../../../../data/model/address/address_model.dart';
import '../../../../data/model/location/user_location.dart';
import '../../../../data/preference/preference_manager.dart';
import '../../../../widgets/dialogs/confirm_action_dialog.dart';
import 'package:geocoding/geocoding.dart' as geoCode;

class AddAddressViewModel extends GetxController {
  final TextEditingController addressLine1 = TextEditingController();
  final TextEditingController addressLine2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController county = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController postCode = TextEditingController();

  final PreferenceManager _preference =
      Get.find(tag: (PreferenceManager).toString());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Add Form key

  AddressModel? addressModel;
  bool isDataChanged = false;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    _loadAddressModel();
    _setupListeners();
  }

  void onAllowAccessToLocation() async {
    isLoading = true;
    update();

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
    _updateControllers();

    _preference.setUserLocation(userLocation: userLocation);
    if (addressModel != null) {
      _preference.setUserAddress(addressModel!);
    }
    isLoading = false;
    update();
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

  void _setupListeners() {
    addressLine1.addListener(_onDataChanged);
    addressLine2.addListener(_onDataChanged);
    city.addListener(_onDataChanged);
    county.addListener(_onDataChanged);
    country.addListener(_onDataChanged);
    postCode.addListener(_onDataChanged);
  }

  // Function to check for data changes in the form
  void _onDataChanged() {
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
    if (formKey.currentState!.validate()) {
      addressModel = AddressModel(
        addressLine1: addressLine1.text,
        addressLine2: addressLine2.text,
        city: city.text,
        county: county.text,
        country: country.text,
        postalCode: postCode.text,
      );
      addressModel?.completeAddress = addressModel?.generateCompleteAddress();
      isDataChanged = false;
      update();
      Get.back(result: addressModel);
    }
  }

  // Validation for city, county, and country (Only allow letters)
  String? validateOnlyLetters(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters';
    }
    return null;
  }

  // Validation for post code (Allow alphanumeric up to 6 characters)
  String? validatePostCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Post code is required';
    }
    if (!RegExp(r'^[A-Za-z0-9]{3} ?[A-Za-z0-9]{3}$').hasMatch(value)) {
      return 'Post code must be 6 characters long';
    }
    return null;
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
