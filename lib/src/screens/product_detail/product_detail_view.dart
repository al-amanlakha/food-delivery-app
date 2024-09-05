import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/src/extensions/media_query_values.dart';
import 'package:food_delivery/src/screens/product_detail/reviews/reviews_view.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../../widgets/buttons/generic_button.dart';
import '../../widgets/sliver_persistent_header/sliver_tab_bar_delegate.dart';
import '../../widgets/smart_image/smart_image_provider.dart';
import 'nutrition/nutrition_view.dart';
import 'product_detail_view_model.dart';


class ProductDetailView extends StatelessWidget {
  static const String id = "/PRODUCT_DETAIL_VIEW";

  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.gradientColor2,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: GetBuilder<ProductDetailViewModel>(
        builder: (controller) {
          final model = controller.model;
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: NestedScrollView(
                controller: controller.scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Container(
                        height: context.screenHeight * 0.35,
                        decoration: const BoxDecoration(
                          gradient: AppColors.radialGradient,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Hero(
                                tag: model.id,
                                child: SmartImageProvider(
                                  imageUrl: model.image,
                                  fit: BoxFit.contain,
                                  height: context.screenHeight * 0.28,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppValues.defaultPadding,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: controller.onBackTap,
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                          AppValues.padding8,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.blackishGrey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        controller.model.isFavourite
                                            ? AppImages.saved
                                            : AppImages.unsaved,
                                        fit: BoxFit.contain,
                                        height: 40,
                                        width: 40,
                                      ),
                                      onPressed:
                                          controller.toggleFavoriteStatus,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      AppValues.defaultRadius,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                              horizontal: AppValues.defaultPadding,
                            ) +
                            const EdgeInsets.only(
                              bottom: AppValues.defaultPadding,
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title,
                              style: AppTextStyles.heading2,
                            ),
                            const SizedBox(
                              height: AppValues.margin12,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "£ ${controller.getTotalPrice()}",
                                  style: AppTextStyles.heading3
                                      .copyWith(color: AppColors.orange),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: controller.decrementQuantity,
                                      child: const Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: AppColors.orange,
                                      ),
                                    ),
                                    defaultWidthSpacing,
                                    Text(
                                      controller.quantity.toString(),
                                      style: AppTextStyles.title,
                                    ),
                                    defaultWidthSpacing,
                                    InkWell(
                                      onTap: controller.incrementQuantity,
                                      child: const Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: AppColors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppValues.margin12,
                            ),
                            Text(
                              model.description,
                              style: AppTextStyles.text1
                                  .copyWith(color: AppColors.darkGrey),
                            ),
                            defaultHeightSpacing,
                            Container(
                              padding: AppPaddings.defaultPaddingAll,
                              decoration: BoxDecoration(
                                color: AppColors.lightWhite,
                                borderRadius: BorderRadius.circular(
                                  AppValues.defaultRadius,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildItem(PhosphorIconsBold.forkKnife,
                                      model.restaurantName),
                                  const VerticalDivider(
                                      color: AppColors.lightGrey, width: 1),
                                  _buildItem(PhosphorIconsBold.fireSimple, "430"),
                                  const VerticalDivider(
                                      color: AppColors.lightGrey, width: 1),
                                  _buildItem(PhosphorIconsBold.star,
                                      model.ratings.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: defaultHeightSpacing,
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverTabBarDelegate(
                        tabBar: TabBar(
                          padding: EdgeInsets.zero,
                          onTap: controller.onTapTabIndex,
                          indicatorColor: AppColors.orange,
                          controller: controller.tabController,
                          labelPadding: AppPaddings.defaultPaddingHorizontal,
                          unselectedLabelStyle: AppTextStyles.text3
                              .copyWith(fontSize: 16, color: AppColors.grey),
                          labelStyle: AppTextStyles.heading3
                              .copyWith(fontSize: 16, color: AppColors.orange),
                          tabs: List.generate(
                            controller.tabs.length,
                            (index) => Tab(
                              iconMargin: EdgeInsets.zero,
                              text: controller.tabs[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: controller.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    NutritionView(),
                    ReviewsView()
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.defaultPadding,
                vertical: AppValues.padding10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GenericButton(
                    onPressed: () {},
                    title: Text(
                      AppStrings.addToCart,
                      style:
                          AppTextStyles.title.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(PhosphorFlatIconData iconPath, String text) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhosphorIcon(iconPath, color: AppColors.orange, size: 24,),
          const SizedBox(
            width: AppValues.margin4,
          ),
          const SizedBox(
            height: AppValues.margin4,
          ),
          Text(
            text,
            style: AppTextStyles.heading3
                .copyWith(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
