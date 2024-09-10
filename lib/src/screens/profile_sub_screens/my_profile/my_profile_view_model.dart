import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/model/profile/user_model.dart';
import '../../../utils/image_picker_service.dart';
import '../../../utils/validators.dart';
import '../../../widgets/dialogs/confirm_action_dialog.dart';

class MyProfileViewModel extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ImagePickerService _imagePickerService = ImagePickerService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? userModel;
  bool isDataChanged = false;
  bool isSaving = false; // Flag to indicate saving progress
  bool isUploadingImage = false; // Flag for uploading image
  File? imageFile;

  @override
  void onInit() {
    super.onInit();
    userModel = Get.arguments as UserModel?;
    updateControllers();
    mobileController.addListener(_onDataChanged);
    nameController.addListener(_onDataChanged);
    emailController.addListener(_onDataChanged);
  }

  void updateControllers() {
    mobileController.text = userModel?.phoneNumber ?? '';
    nameController.text = userModel?.fullName ?? '';
    emailController.text = userModel?.email ?? '';
    isDataChanged = false;
    update();
  }

  void proceedProfileOnTap() {
    if (userModel?.profileImageUrl != null) {
      Get.dialog(
        ConfirmActionDialog(
          title: "Confirm",
          message: "Are you sure you want to change your profile picture?",
          onConfirm: () => pickImage(),
        ),
      );
    } else {
      pickImage();
    }
  }

  void pickImage() async {
    File? selectedImage = await _imagePickerService.pickImageFromGallery();
    isUploadingImage = true;
    update();
    if (selectedImage != null) {
      imageFile = selectedImage;
      String imageUrl = await uploadImageToFirebase(imageFile!);
      userModel?.profileImageUrl = imageUrl;
      _onDataChanged();
    }
    isUploadingImage = false;
    update();
  }

  Future<String> uploadImageToFirebase(File image) async {
    Reference ref =
        _storage.ref().child('profileImages/${_auth.currentUser?.uid}');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  bool validateForm() {
    // Validate each field and return true if all fields are valid.
    bool isMobileValid =
        Validator.validatePhoneNumber(mobileController.text.trim()) == null;
    bool isNameValid =
        Validator.validateName(nameController.text.trim()) == null;
    bool isEmailValid =
        Validator.validateEmail(emailController.text.trim()) == null;

    return isMobileValid && isNameValid && isEmailValid;
  }

  void saveProfile() async {
    if (isDataChanged && !isSaving) {
      if (validateForm()) {
        // Only proceed if the form is valid
        isSaving = true;
        update();

        // Continue with the saving process
        userModel?.fullName = nameController.text.trim();
        userModel?.firstName =
            NameUtility.getFirstName(nameController.text.trim()) ?? "";
        userModel?.lastName =
            NameUtility.getLastName(nameController.text.trim()) ?? "";
        userModel?.phoneNumber = mobileController.text.trim();
        userModel?.email = emailController.text.trim().isEmpty
            ? "abc@mail.com"
            : emailController.text.trim();

        await _auth.currentUser?.updateDisplayName(userModel?.fullName);
        await _auth.currentUser?.updatePhotoURL(userModel?.profileImageUrl);
        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .set(userModel!.toJson());

        isDataChanged = false;
        isSaving = false;
        update();
      } else {
        // Handle the case when validation fails
        _showToast(
          "Please correct the form errors before saving.",
        );
      }
    }
  }

  void onBackTap() {
    if (isDataChanged) {
      Get.dialog(
        ConfirmActionDialog(
          title: "Discard Changes",
          message: "Are you sure you want to discard changes?",
          onConfirm: () => Get.back(),
        ),
      );
    } else {
      Get.back(result: userModel);
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
    super.dispose();
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
