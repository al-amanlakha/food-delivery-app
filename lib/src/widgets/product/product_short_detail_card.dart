import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../data/model/product/food_item_model.dart';
import '../smart_image/smart_image_provider.dart';


class ProductShortDetailCard extends StatelessWidget {
  final FoodItemModel model;
  final VoidCallback? onTap;
  final VoidCallback onFavouriteTap;

  const ProductShortDetailCard({
    super.key,
    this.onTap,
    required this.model,
    required this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppValues.radius18,
            ),
          ),
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    AppValues.radius18,
                  ),
                ),
                child: Container(
                  height: 130,
                  color: AppColors.gradientColor1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: model.id,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmartImageProvider(
                            imageUrl: model.image,
                            fit: BoxFit.contain,
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
              Padding(
                padding: const EdgeInsets.all(
                  AppValues.padding8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: AppTextStyles.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: AppValues.margin4,
                    ),
                    Text(
                      model.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppTextStyles.text4.copyWith(color: AppColors.grey),
                    ),
                    const SizedBox(
                      height: AppValues.margin4,
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
                    const SizedBox(
                      height: AppValues.margin8,
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
            ],
          ),
        ),
      ),
    );
  }
}
