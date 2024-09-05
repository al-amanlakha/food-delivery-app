import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import 'my_orders_view_model.dart';
import 'past_orders/past_orders.dart';
import 'up_coming_orders/up_coming_orders.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrdersViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: SubProfileAppBar(
            title: AppStrings.myOrders,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: TabBar(
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
          body: TabBarView(
            controller: controller.tabController,
            children: const [
              UpComingOrders(),
              PastOrders(),
            ],
          ),
        );
      },
    );
  }
}
