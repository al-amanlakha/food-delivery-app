import 'dart:io';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/constants/app_text_styles.dart';
import 'package:food_delivery/src/constants/app_values.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../data/model/review/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel model;

  const ReviewCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.lightGrey,
              backgroundImage: model.image != null
                  ? (model.image!.startsWith('http')
                      ? NetworkImage(model.image!)
                      : FileImage(File(model.image!)))
                  : null,
              child: model.image == null
                  ? const Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 36,
                    )
                  : null,
            ),
            const SizedBox(
              width: AppValues.margin8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: AppTextStyles.text1,
                ),
                RatingBar.readOnly(
                  filledColor: AppColors.orange,
                  emptyColor: AppColors.lightGrey,
                  initialRating: model.rating,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  maxRating: 5,
                  size: 24,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: AppValues.margin10,),
        if (model.review != null) ...[
          Text(
            model.review!,
            style: AppTextStyles.text2.copyWith(
              color: AppColors.lightGrey,
            ),
          ),
          const SizedBox(height: AppValues.margin10,),
        ],
        Text(
          DateFormat('dd/MM/yyyy').format(
            model.reviewDate,
          ),
          style: AppTextStyles.text2.copyWith(
            color: AppColors.lightGrey,
          ),
        ),
      ],
    );
  }
}
