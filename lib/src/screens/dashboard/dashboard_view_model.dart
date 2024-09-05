import 'package:food_delivery/src/screens/dashboard/offers/offers_view.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/app_strings.dart';
import '../../data/model/dashboard/bottom_nav_item_model.dart';
import 'cart/cart_view.dart';
import 'home/home_view.dart';
import 'profile/profile_view.dart';
import 'saved/saved_view.dart';

class DashboardViewModel extends GetxController {
  int currentIndex = 4;
  List<BottomNavItemModel> bottomNavItemsList = <BottomNavItemModel>[
    BottomNavItemModel(
      title: AppStrings.offers,
      iconData: PhosphorIconsRegular.gift,
    ),
    BottomNavItemModel(
      title: AppStrings.saved,
      iconData: PhosphorIconsRegular.heart,
    ),
    BottomNavItemModel(
      title: AppStrings.cart,
      iconData: PhosphorIconsRegular.shoppingCart,
    ),
    BottomNavItemModel(
      title: AppStrings.profile,
      iconData: PhosphorIconsRegular.user,
    ),
  ];

  void onBottomNavTap(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    update();

    switch (currentIndex) {
      case 0:
        goToPage(OffersView.id);
        break;
      case 1:
        goToPage(SavedView.id, arguments: "SAVED");
        break;
      case 2:
        goToPage(CartView.id);
        break;
      case 3:
        goToPage(ProfileView.id);
        break;
      case 4:
        goToPage(HomeView.id);
        break;
    }
  }

  void goToPage(String routeName, {dynamic arguments}) {
    Get.offNamed(
      routeName,
      arguments: arguments,
      id: 1,
    );
  }
}
