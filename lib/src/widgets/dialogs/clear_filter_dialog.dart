import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class ClearFilterDialog extends StatelessWidget {
  final VoidCallback onClearAll;

  const ClearFilterDialog({
    super.key,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirm",
        style: AppTextStyles.title.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: const Text(
        "Are you sure you want to clear all filters?",
        style: AppTextStyles.text1,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Cancel",
            style: AppTextStyles.title.copyWith(
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          onPressed: onClearAll,
          child: Text(
            "Clear All",
            style: AppTextStyles.title.copyWith(
              fontSize: 14,
              color: AppColors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
