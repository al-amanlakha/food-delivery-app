import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import 'nutrition_view_model.dart';

class NutritionView extends StatelessWidget {
  const NutritionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionViewModel>(
      builder: (controller) {
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverPadding(
              padding: AppPaddings.defaultPaddingAll,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: AppPaddings.defaultPaddingAll,
                      color: AppColors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            AppStrings.servingPerRecipe,
                            style: AppTextStyles.text1,
                          ),
                          defaultHeightSpacing,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppValues.padding12,
                              horizontal: AppValues.padding2,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.lightGrey,
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: AppColors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.perServing,
                                    style: AppTextStyles.text1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppStrings.dailyValue,
                                    style: AppTextStyles.text1,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final model = controller.nutritionList[index];
                              return ListTile(
                                title: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: "${model.name}: ",
                                    style: AppTextStyles.text2,
                                    children: [
                                      TextSpan(
                                        text: model.quantity,
                                        style: AppTextStyles.text2.copyWith(
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                trailing: Text(
                                  "${model.dailyValue.toStringAsFixed(0)}%",
                                  style: AppTextStyles.text2,
                                  textAlign: TextAlign.right,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                defaultHeightSpacing,
                            itemCount: 6,
                          ),
                          defaultHeightSpacing,
                          const Divider(
                            height: 8,
                            color: AppColors.lightGrey,
                            thickness: 8,
                          ),
                          defaultHeightSpacing,
                          const Text(
                            AppStrings.basedOnCalorie,
                            style: AppTextStyles.text1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
