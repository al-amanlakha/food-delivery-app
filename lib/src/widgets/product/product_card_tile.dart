import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../data/model/product/food_item_model.dart';
import '../smart_image/smart_image_provider.dart';

class ProductCardTile extends StatelessWidget {
  final FoodItemModel model;
  final VoidCallback? onTap;
  final VoidCallback onFavouriteTap;

  const ProductCardTile({
    super.key,
    this.onTap,
    required this.model,
    required this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppValues.radius18,
          ),
        ),
        color: AppColors.white,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(
                      AppValues.radius18,
                    ),
                  ),
                  child: Container(
                    color: AppColors.gradientColor1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: model.id,
                            child: SmartImageProvider(
                              imageUrl: model.image,
                              fit: BoxFit.contain,
                              height: 120,
                            ),
                          ),
                        ),
                        Positioned(
                          right: AppValues.margin8,
                          top: AppValues.margin8,
                          child: InkWell(
                            onTap: onFavouriteTap,
                            child: SvgPicture.asset(
                              model.isFavourite
                                  ? AppImages.saved
                                  : AppImages.unsaved,
                              fit: BoxFit.contain,
                              height: 32,
                              width: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppValues.padding8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title,
                        style: AppTextStyles.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        model.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppTextStyles.text4.copyWith(color: AppColors.grey),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const PhosphorIcon(PhosphorIconsRegular.forkKnife, color: AppColors.lightGrey, size: 20,),
                          const SizedBox(
                            width: AppValues.margin4,
                          ),
                          Text(
                            model.restaurantName,
                            style: AppTextStyles.text3
                                .copyWith(color: AppColors.darkGrey),
                          ),
                          const SizedBox(
                            width: AppValues.margin8,
                          ),
                          const PhosphorIcon(PhosphorIconsRegular.star, color: AppColors.lightGrey, size: 20,),
                          const SizedBox(
                            width: AppValues.margin4,
                          ),
                          Text(
                            model.ratings.toString(),
                            style: AppTextStyles.text3
                                .copyWith(color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                      Text(
                        "£ ${model.price}",
                        style: AppTextStyles.text3.copyWith(
                          color: AppColors.orange,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
