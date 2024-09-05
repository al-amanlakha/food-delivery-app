import 'package:flutter/material.dart';
import 'package:food_delivery/src/extensions/media_query_values.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/home/home_view_all_header.dart';
import '../../../widgets/product/product_short_detail_card.dart';
import '../../../widgets/sliver_persistent_header/sliver_tab_bar_delegate.dart';
import '../../../widgets/textfield/generic_search_field.dart';
import '../../product_detail/product_detail_view.dart';
import '../../view_all/view_all.dart';
import 'home_view_model.dart';
import 'tabs/appetizers/appetizers.dart';
import 'tabs/beverages/beverages.dart';
import 'tabs/desserts/desserts.dart';
import 'tabs/main_course/main_course.dart';
import 'tabs/side_dishes/side_dishes.dart';

class HomeView extends StatelessWidget {
  static const String id = "/HOME_VIEW";

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        return Scaffold(
          body: NotificationListener(
            onNotification: controller.onNotification,
            child: NestedScrollView(
              controller: controller.scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    collapsedHeight: controller.collapsedBarHeight,
                    expandedHeight: controller.expandedBarHeight,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(
                          AppValues.radius20,
                        ),
                      ),
                    ),
                    backgroundColor: AppColors.gradientColor2 ,
                    title: AnimatedOpacity(
                      duration: const Duration(
                          milliseconds: AppValues.defaultAnimationDuration),
                      opacity: controller.isCollapsed ? 1 : 0,
                      child: GenericSearchField(
                        readOnly: true,
                        onTap: controller.searchOnTap,
                        hintText: AppStrings.searchDish,
                        controller: controller.searchController,
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Card(
                        color: AppColors.gradientColor2,
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(
                              AppValues.radius20,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: context.safeAreaVertical) +
                                  AppPaddings.defaultPaddingAll,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello Amandeep!",
                                style: AppTextStyles.heading1.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              defaultHeightSpacing,
                              Text(
                                AppStrings.whatWouldYouLikeToOrder,
                                style: AppTextStyles.text1.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              const Spacer(),
                              GenericSearchField(
                                readOnly: true,
                                onTap: controller.searchOnTap,
                                hintText: AppStrings.searchDish,
                                controller: controller.searchController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: defaultHeightSpacing,
                  ),
                  SliverPadding(
                    padding: AppPaddings.defaultPaddingHorizontal,
                    sliver: SliverToBoxAdapter(
                      child: HomeViewAllHeader(
                        title: AppStrings.popularRestaurants,
                        viewAll: () {
                          Get.toNamed(
                            ViewAll.id,
                            arguments: {
                              'pageTitle': AppStrings.popularRestaurants,
                              'recipes': controller.popularRestaurantsList,
                              // Ensure this list is available
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: defaultHeightSpacing,
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: AppPaddings.defaultPaddingHorizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          children: List.generate(
                            controller.popularRestaurantsList.length,
                            (index) {
                              final model =
                                  controller.popularRestaurantsList[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index <
                                          controller.popularRestaurantsList.length -
                                              1
                                      ? AppValues.margin16
                                      : 0,
                                ),
                                child: ProductShortDetailCard(
                                  model: model,
                                  onTap: () {
                                    Get.toNamed(ProductDetailView.id,
                                        arguments: model);
                                  },
                                  onFavouriteTap: () =>
                                      controller.toggleFavoriteStatus(model.id,
                                          controller.popularRestaurantsList),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: defaultHeightSpacing,
                  ),
                  SliverPadding(
                    padding: AppPaddings.defaultPaddingHorizontal,
                    sliver: SliverToBoxAdapter(
                      child: HomeViewAllHeader(
                        title: AppStrings.popularFood,
                        viewAll: () {
                          Get.toNamed(
                            ViewAll.id,
                            arguments: {
                              'pageTitle': AppStrings.popularFood,
                              'recipes': controller.popularFoodList,
                              // Ensure this list is available
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: defaultHeightSpacing,
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: AppPaddings.defaultPaddingHorizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          children: List.generate(
                            controller.popularFoodList.length,
                            (index) {
                              final model = controller.popularFoodList[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index <
                                          controller.popularFoodList.length - 1
                                      ? AppValues.margin16
                                      : 0,
                                ),
                                child: ProductShortDetailCard(
                                  model: model,
                                  onTap: () {
                                    Get.toNamed(ProductDetailView.id,
                                        arguments: model);
                                  },
                                  onFavouriteTap: () =>
                                      controller.toggleFavoriteStatus(
                                          model.id, controller.popularFoodList),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: defaultHeightSpacing,
                  ),
                  SliverPadding(
                    padding: AppPaddings.defaultPaddingHorizontal,
                    sliver: SliverToBoxAdapter(
                      child: HomeViewAllHeader(
                        title: AppStrings.recentItems,
                        viewAll: () {
                          Get.toNamed(
                            ViewAll.id,
                            arguments: {
                              'pageTitle': AppStrings.recentItems,
                              'recipes': controller.popularFoodList,
                              // Ensure this list is available
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverTabBarDelegate(
                      tabBar: TabBar(
                        isScrollable: true,
                        padding: EdgeInsets.zero,
                        onTap: controller.onTapTabIndex,
                        tabAlignment: TabAlignment.start,
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
                  MainCourse(),
                  Appetizers(),
                  SideDishes(),
                  Desserts(),
                  Beverages(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
