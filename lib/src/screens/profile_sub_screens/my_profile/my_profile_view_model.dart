import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../data/model/profile/user_profile_model.dart';
import '../../../data/preference/preference_manager.dart';
import '../../../utils/image_picker_service.dart';
import '../../../widgets/dialogs/confirm_action_dialog.dart';

class MyProfileViewModel extends GetxController {
  final PreferenceManager _preference =
      Get.find(tag: (PreferenceManager).toString());
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _imagePickerService = ImagePickerService();
  UserProfileModel? model;
  bool isDataChanged = false;
  File? imageFile;

  @override
  void onInit() {
    loadUserProfile();
    mobileController.addListener(_onDataChanged);
    nameController.addListener(_onDataChanged);
    emailController.addListener(_onDataChanged);
    super.onInit();
  }

  void loadUserProfile() async {
    UserProfileModel? storedModel = await _preference.getUserProfile();
    if (storedModel != null) {
      model = storedModel;
    } else {
      model =
          Get.arguments as UserProfileModel?; // Safely cast to UserProfileModel
    }
    if (model != null) {
      updateControllers();
    } else {
      model = UserProfileModel(
          userName: '', phoneNumber: ''); // Default empty model
    }
  }

  void updateControllers() {
    mobileController.text = model!.phoneNumber;
    nameController.text = model!.userName;
    if (model!.userEmail != null) {
      emailController.text = model!.userEmail!;
    }
    isDataChanged = false;
    update();
  }

  void proceedProfileOnTap() {
    if (model?.userProfileImage != null) {
      Get.dialog(
        ConfirmActionDialog(
          title: "Confirm",
          message: "Are you sure you want to change your profile picture",
          onConfirm: () => pickImage(),
        ),
      );
    } else {
      pickImage();
    }
  }

  void pickImage() async {
    final File? imageFile = await _imagePickerService
        .pickImageFromGallery(); // Or use pickImageFromCamera for camera
    if (imageFile != null) {
      this.imageFile = imageFile;
      model?.userProfileImage = imageFile.path;
      _onDataChanged();
      update();
    }
  }

  void saveProfile() {
    if (isDataChanged) {
      final model = UserProfileModel(
        userAddress: this.model?.userAddress,
        userName: nameController.text.trim(),
        phoneNumber: mobileController.text.trim(),
        userProfileImage: this.model?.userProfileImage,
        userEmail: emailController.text.trim().isEmpty
            ? null
            : emailController.text.trim(),
      );
      this.model = model;
      _preference.setUserProfile(model);
      isDataChanged = false; // Reset the flag after saving
      update();
    }
  }

  void onBackTap() {
    if (isDataChanged) {
      Get.dialog(
        ConfirmActionDialog(
          title: "Discard",
          message: "Are you sure you want to discard changes",
          onConfirm: () => Get.back(),
        ),
      );
    } else {
      Get.back(
        result: model,
      );
    }
  }

  void _onDataChanged() {
    if (!isDataChanged) {
      isDataChanged = true;
      update();
    }
  }

  @override
  void dispose() {
    mobileController.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.removeListener(_onDataChanged);
    nameController.removeListener(_onDataChanged);
    emailController.removeListener(_onDataChanged);
    super.dispose();
  }
}
