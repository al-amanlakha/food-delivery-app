import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../data/model/recipe/recipe_model.dart';
import '../../utils/global_utils.dart';
import 'search_result_view/search_results_view.dart';
import 'search_result_view/search_results_view_model.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<Recipe> recipeList;

  const SearchResultsWidget({
    super.key,
    required this.recipeList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: AppPaddings.defaultPaddingAll,
      itemBuilder: (context, index) {
        final model = recipeList[index];
        return InkWell(
          onTap: () {
            Get.to(
              () => const SearchResultsView(),
              curve: Curves.ease,
              transition: Transition.cupertino,
              duration: const Duration(
                  milliseconds: AppValues.defaultAnimationDuration),
              arguments: model.recipeName,
              binding: BindingsBuilder(
                () => Get.lazyPut(
                  () => SearchResultsViewModel(),
                  fenix: true,
                ),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.white,
                backgroundImage: model.recipeImage != null
                    ? (model.recipeImage!.startsWith('http')
                        ? NetworkImage(model.recipeImage!)
                        : AssetImage(
                            model.recipeImage!,
                          ))
                    : null,
                child: model.recipeImage == null
                    ? SvgPicture.asset(
                        AppImages.placeholderThumbnail,
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
              defaultWidthSpacing,
              Text(
                model.recipeName,
                style: AppTextStyles.text2,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return defaultHeightSpacing;
      },
      itemCount: recipeList.length,
    );
  }
}
