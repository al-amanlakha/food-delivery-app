import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_paddings.dart';
import '../../../../../utils/global_utils.dart';
import '../../../../../widgets/product/product_card_tile.dart';
import '../../../../product_detail/product_detail_view.dart';
import 'side_dishes_view_model.dart';

class SideDishes extends StatelessWidget {
  const SideDishes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideDishesViewModel>(builder: (controller) {
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: AppPaddings.defaultPaddingAll,
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final model = controller.sideDishList[index];
                return ProductCardTile(
                  model: model,
                  onTap: (){
                    Get.toNamed(ProductDetailView.id, arguments: model);
                  },
                  onFavouriteTap: () =>
                      controller.toggleFavoriteStatus(model.id),
                );
              },
              separatorBuilder: (context, index) {
                return defaultHeightSpacing;
              },
              itemCount: controller.sideDishList.length,
            ),
          ),
        ],
      );
    },);
  }
}
