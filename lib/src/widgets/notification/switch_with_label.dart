import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_text_styles.dart';


class SwitchWithLabel extends StatelessWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const SwitchWithLabel({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.defaultPaddingHorizontal,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.text1,
            ),
          ),
          Switch(
            value: initialValue,
            activeColor: AppColors.white,
            activeTrackColor: AppColors.orange,
            inactiveTrackColor: AppColors.white,
            inactiveThumbColor: AppColors.orange,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
