import 'dart:io';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/data/model/profile/user_model.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/profile/user_profile_model.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/review/review_card.dart';
import '../../../widgets/textfield/generic_textfield.dart';
import 'reviews_view_model.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsViewModel>(
      builder: (controller) {
        final UserModel? user = controller.userProfile;
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverPadding(
              padding: AppPaddings.defaultPaddingAll,
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        AppValues.padding12,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.warmWhite,
                        borderRadius: BorderRadius.circular(
                          AppValues.radius30,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          user != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.lightGrey,
                                  backgroundImage: user.profileImageUrl != null
                                      ? (user.profileImageUrl!
                                              .startsWith('http')
                                          ? NetworkImage(user.profileImageUrl!)
                                          : FileImage(
                                              File(user.profileImageUrl!)))
                                      : null,
                                  child: user.profileImageUrl == null
                                      ? const Icon(
                                          Icons.person,
                                          color: AppColors.white,
                                          size: 36,
                                        )
                                      : null,
                                )
                              : const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.lightGrey,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                ),
                          const SizedBox(
                            width: AppValues.margin10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: AppStrings.yourRating,
                                    style: AppTextStyles.text2.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const WidgetSpan(
                                        child: SizedBox(
                                          width: AppValues.margin4,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppStrings.required,
                                        style: AppTextStyles.text4.copyWith(
                                          color: AppColors.lightGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RatingBar(
                                  filledColor: AppColors.orange,
                                  emptyColor: AppColors.lightGrey,
                                  initialRating: controller.initialRating,
                                  filledIcon: Icons.star,
                                  emptyIcon: Icons.star_border,
                                  maxRating: 5,
                                  size: 24,
                                  onRatingChanged: controller.onRatingChanged,
                                ),
                                const SizedBox(
                                  height: AppValues.margin12,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: AppStrings.yourReview,
                                    style: AppTextStyles.text2.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      const WidgetSpan(
                                        child: SizedBox(
                                          width: AppValues.margin4,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppStrings.optional2,
                                        style: AppTextStyles.text4.copyWith(
                                          color: AppColors.lightGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: AppValues.margin8,
                                ),
                                GenericTextField(
                                  controller: controller.reviewController,
                                  hintText: AppStrings.shareYourReview,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (val) {
                                    controller.onSubmit();
                                  },
                                  contentPadding:
                                      const EdgeInsets.all(AppValues.padding8),
                                  minLines: 3,
                                  maxLines: 6,
                                ),
                                const SizedBox(
                                  height: AppValues.margin12,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    GenericButton(
                                      height: 60,
                                      onPressed: controller.initialRating > 0
                                          ? controller.onSubmit
                                          : null, // Disable button if no rating
                                      title: Text(
                                        AppStrings.submit,
                                        style: AppTextStyles.title.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    defaultHeightSpacing,
                    Text(
                      "${controller.reviews.length.toString()} Reviews",
                      style: AppTextStyles.heading2,
                    ),
                    defaultHeightSpacing,
                    ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final model = controller.reviews[index];
                        return ReviewCard(model: model);
                      },
                      separatorBuilder: (context, index) =>
                          defaultHeightSpacing,
                      itemCount: controller.reviews.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
