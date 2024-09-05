import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../data/model/product/food_item_model.dart';
import '../../utils/global_utils.dart';
import '../../widgets/buttons/filter_button.dart';
import '../../widgets/buttons/generic_button.dart';

import '../../widgets/product/product_card_tile.dart';
import '../filter/filter_view_model.dart';
import '../product_detail/product_detail_view.dart';
import 'view_all_view_model.dart';

class ViewAll extends StatelessWidget {
  static const String id = "/VIEW_ALL";
  final String pageTitle = Get.arguments['pageTitle'] as String;
  final List<FoodItemModel> recipes =
      Get.arguments['recipes'] as List<FoodItemModel>;

  ViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Get.delete<FilterViewModel>(force: true);
        }
      },
      child: GetBuilder<ViewAllViewModel>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.gradientColor2,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Get.delete<FilterViewModel>(force: true);
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
              ),
              title: Text(
                pageTitle,
                style: AppTextStyles.heading2.copyWith(color: AppColors.white),
              ),
            ),
            body: SingleChildScrollView(
              padding: AppPaddings.defaultPaddingAll,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterButton(
                        onTap: controller.onTapFilter,
                      ),
                      GenericButton(
                        onPressed: controller.onSortBy,
                        isBorder: true,
                        height: 40,
                        color: Colors.transparent,
                        leading: const SizedBox(),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              AppStrings.sort,
                              style: AppTextStyles.text1,
                            ),
                            const SizedBox(
                              width: AppValues.margin8,
                            ),
                            SvgPicture.asset(
                              AppImages.sort,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final model = recipes[index];
                        return ProductCardTile(
                          model: model,
                          onTap: (){
                            Get.toNamed(ProductDetailView.id, arguments: model);
                          },
                          onFavouriteTap: () => controller.toggleFavoriteStatus(
                              model.id, recipes),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return defaultHeightSpacing;
                      },
                      itemCount: recipes.length),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
