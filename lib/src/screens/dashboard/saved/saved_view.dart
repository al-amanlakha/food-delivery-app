import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/product/product_card_tile.dart';
import '../../product_detail/product_detail_view.dart';
import 'saved_view_model.dart';

class SavedView extends StatelessWidget {
  static const String id = "/SAVED_VIEW";

  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments;
    return GetBuilder<SavedViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text(
              AppStrings.savedDishes,
              style: AppTextStyles.heading2,
            ),
          ),
          body: controller.favoriteRecipes.isEmpty
              ? const Center(
                  child: Text(
                    "Nothing saved yet",
                    style: AppTextStyles.heading3,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: AppPaddings.defaultPaddingAll,
                  itemBuilder: (context, index) {
                    final model = controller.favoriteRecipes[index];
                    return ProductCardTile(
                        model: model,
                        onTap: () {
                          Get.toNamed(ProductDetailView.id, arguments: model);
                        },
                        onFavouriteTap: () => controller.toggleFavoriteStatus(
                            model.id, controller.favoriteRecipes));
                  },
                  separatorBuilder: (context, index) {
                    return defaultHeightSpacing;
                  },
                  itemCount: controller.favoriteRecipes.length,
                ),
        );
      },
    );
  }
}
