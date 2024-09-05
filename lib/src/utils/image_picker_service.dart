import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  // Pick an image from the camera
  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }
}
