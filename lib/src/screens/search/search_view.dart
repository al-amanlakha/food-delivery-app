import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';


import '../../widgets/textfield/generic_search_field.dart';
import 'popular_searches_widget.dart';
import 'search_results_widget.dart';
import 'search_view_model.dart';

class SearchView extends StatelessWidget {
  static const String id = "/SEARCH_VIEW";

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.gradientColor2,
            leading: const BackButton(
              color: AppColors.white,
            ),
            centerTitle: true,
            title: Text(
              AppStrings.searchDishes,
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
                child: GenericSearchField(
                  autoFocus: true,
                  hintText: AppStrings.searchDishes,
                  controller: controller.searchController,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: controller.onSearchSubmit,
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
            ),
          ),
          body: IndexedStack(
            index: controller.currentIndex,
            children: [
              PopularSearchesWidget(
                recipeList: controller.popularRecipes,
              ),
              SearchResultsWidget(
                recipeList: controller.filteredSearchResults,
              ),
            ],
          ),
        );
      },
    );
  }
}
