import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function onConfirm;

  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTextStyles.title.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        message,
        style: AppTextStyles.text1,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Cancel',
            style: AppTextStyles.title.copyWith(
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Get.back(); // Close the dialog
          },
        ),
        TextButton(
          child: Text(
            'Confirm',
            style: AppTextStyles.title.copyWith(
              fontSize: 14,
              color: AppColors.orange,
            ),
          ),
          onPressed: () {
            onConfirm(); // Execute the confirmation action
            Get.back(); // Close the dialog after confirming
          },
        ),
      ],
    );
  }
}
