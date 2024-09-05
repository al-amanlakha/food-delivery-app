import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_values.dart';


class FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppValues.padding8,),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.orange,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppImages.filter,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
