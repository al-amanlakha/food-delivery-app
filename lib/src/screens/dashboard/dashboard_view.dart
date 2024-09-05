import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../routes/app_routes.dart';
import 'dashboard_view_model.dart';
import 'home/home_view.dart';

class DashboardView extends StatelessWidget {
  static const String id = "/DASHBOARD_VIEW";

  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardViewModel>(
      builder: (controller) {
        return Scaffold(
          body: Navigator(
              key: Get.nestedKey(1),
              initialRoute: HomeView.id,
              onGenerateRoute: AppRoutes.instance.onGenerateRoute,
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.onBottomNavTap(4);
            },
            shape: const CircleBorder(),
            backgroundColor: controller.currentIndex == 4
                ? AppColors.orange
                : AppColors.white,
            child: PhosphorIcon(
              PhosphorIconsLight.house,
              color: controller.currentIndex == 4
                  ? AppColors.white
                  : AppColors.lightGrey,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            notchMargin: 5,
            color: AppColors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                controller.bottomNavItemsList.length,
                (index) {
                  final model = controller.bottomNavItemsList[index];
                  return IconButton(
                    onPressed: () => controller.onBottomNavTap(index),
                    icon: Column(
                      children: [
                        PhosphorIcon(
                          model.iconData,
                          color: controller.currentIndex == index
                              ? AppColors.orange
                              : AppColors.lightGrey,
                        ),
                        const SizedBox(
                          height: AppValues.margin4,
                        ),
                        Text(
                          model.title,
                          style: AppTextStyles.text3.copyWith(
                            fontSize: 10,
                            color: controller.currentIndex == index
                                ? AppColors.orange
                                : AppColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

/*
BottomNavigationBar(
              elevation: 2,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: controller.onBottomNavTap,
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.orange,
              currentIndex: controller.currentIndex,
              unselectedItemColor: AppColors.blackishGrey,
              unselectedLabelStyle: AppTextStyles.text3.copyWith(fontSize: 10),
              selectedLabelStyle: AppTextStyles.text3.copyWith(fontSize: 10),
              items: List.generate(
                controller.bottomNavItemsList.length,
                (index) {
                  final model = controller.bottomNavItemsList[index];
                  return BottomNavigationBarItem(
                    backgroundColor: AppColors.white,
                    icon: SvgPicture.asset(
                      model.inactiveIcon,
                      fit: BoxFit.contain,
                    ),
                    activeIcon: SvgPicture.asset(
                      model.activeIcon,
                      fit: BoxFit.contain,
                      color: AppColors.orange,
                    ),
                    label: model.title,
                  );
                },
              ),
            )
 */
