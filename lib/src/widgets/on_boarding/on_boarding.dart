import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/src/constants/app_values.dart';
import 'package:food_delivery/src/utils/global_utils.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class OnBoarding extends StatelessWidget {
  final int screenNo;
  final String text, description, image;

  const OnBoarding({
    super.key,
    required this.text,
    required this.description,
    required this.image,
    required this.screenNo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(image),
        defaultHeightSpacing,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (screenNo == 0) ? AppColors.orange : AppColors.lightGrey,
              ),
            ),
            const SizedBox(width: AppValues.margin4,),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (screenNo == 1) ? AppColors.orange : AppColors.lightGrey,
              ),
            ),
            const SizedBox(width: AppValues.margin4,),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (screenNo == 2) ? AppColors.orange : AppColors.lightGrey,
              ),
            ),
          ],
        ),
        defaultHeightSpacing,
        Text(
          text,
          style: AppTextStyles.heading2,
        ),
        defaultHeightSpacing,
        Text(
          description,
          style: AppTextStyles.text4,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
