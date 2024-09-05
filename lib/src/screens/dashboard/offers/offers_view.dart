import 'package:flutter/material.dart';
import 'package:food_delivery/src/constants/app_colors.dart';
import 'package:food_delivery/src/constants/app_paddings.dart';
import 'package:food_delivery/src/extensions/media_query_values.dart';
import 'package:food_delivery/src/screens/dashboard/offers/offers_view_model.dart';
import 'package:food_delivery/src/utils/global_utils.dart';
import 'package:food_delivery/src/widgets/smart_image/smart_image_provider.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../product_detail/product_detail_view.dart';

class OffersView extends StatelessWidget {
  static const String id = "/OFFERS_VIEW";

  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text(
              AppStrings.latestOffers,
              style: AppTextStyles.heading2,
            ),
          ),
          body: ListView.separated(
            padding: AppPaddings.defaultPaddingVertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final model = controller.offersList[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(ProductDetailView.id, arguments: model);
                },
                child: Container(
                  height: context.screenHeight * 0.25,
                  color: AppColors.gradientColor1,
                  alignment: Alignment.center,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: model.id,
                        child: SmartImageProvider(
                          imageUrl: model.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        color: AppColors.blackishGrey.withOpacity(0.2),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ListTile(
                          dense: true,
                          title: Text(model.title, style: AppTextStyles.text1.copyWith(fontWeight: FontWeight.w600,),),
                          subtitle: Row(
                            children: [
                              const PhosphorIcon(PhosphorIconsRegular.forkKnife, color: AppColors.orange, size: 24,),
                              const SizedBox(
                                width: AppValues.margin4,
                              ),
                              Text(
                                model.restaurantName,
                                style: AppTextStyles.text2
                                    .copyWith(color: AppColors.orange),
                              ),
                              const SizedBox(
                                width: AppValues.margin8,
                              ),
                              const PhosphorIcon(PhosphorIconsRegular.star, color: AppColors.orange, size: 24,),
                              const SizedBox(
                                width: AppValues.margin4,
                              ),
                              Text(
                                model.ratings.toString(),
                                style: AppTextStyles.text2
                                    .copyWith(color: AppColors.orange),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => defaultHeightSpacing,
            itemCount: controller.offersList.length,
          ),
        );
      },
    );
  }
}
