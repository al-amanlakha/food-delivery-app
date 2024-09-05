import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';

class HomeViewAllHeader extends StatelessWidget {
  final String title;
  final VoidCallback? viewAll;

  const HomeViewAllHeader({
    super.key,
    this.viewAll,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.heading3,
        ),
        if (viewAll != null)
          InkWell(
            onTap: viewAll,
            child: Text(
              AppStrings.viewAll,
              style: AppTextStyles.text3.copyWith(color: AppColors.orange),
            ),
          ),
      ],
    );
  }
}
