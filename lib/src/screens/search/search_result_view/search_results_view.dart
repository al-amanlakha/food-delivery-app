import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/buttons/filter_button.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/product/product_card_tile.dart';
import '../../../widgets/textfield/generic_search_field.dart';
import '../../product_detail/product_detail_view.dart';
import 'search_results_view_model.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultsViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.gradientColor2,
            leading: const BackButton(
              color: AppColors.white,
            ),
            centerTitle: true,
            title: Text(
              AppStrings.searchResults,
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(
                kToolbarHeight + 20,
              ),
              child: Padding(
                padding: AppPaddings.defaultPaddingAll,
                child: Row(
                  children: [
                    Expanded(
                      child: GenericSearchField(
                        hintText: AppStrings.searchDishes,
                        controller: controller.searchController,
                        textInputAction: TextInputAction.search,
                        suffixIcon: !controller.isTextEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: AppColors.grey,
                                ),
                                iconSize: 18,
                                onPressed: controller.clearSearchField,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(
                      width: AppValues.margin12,
                    ),
                    FilterButton(
                      onTap: controller.onTapFilter,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.searchResults.length} Results",
                      style: AppTextStyles.text2,
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
                defaultHeightSpacing,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final model = controller.searchResults[index];
                    return ProductCardTile(
                      model: model,
                      onTap: () {
                        Get.toNamed(ProductDetailView.id, arguments: model);
                      },
                      onFavouriteTap: () =>
                          controller.toggleFavoriteStatus(model.id, controller.searchResults),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return defaultHeightSpacing;
                  },
                  itemCount: controller.searchResults.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
