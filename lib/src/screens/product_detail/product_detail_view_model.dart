import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../constants/app_values.dart';
import '../../data/model/product/food_item_model.dart';

class ProductDetailViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late FoodItemModel model;
  int quantity = 1;
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void onInit() {
    model = Get.arguments;
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void onBackTap() {
    Get.back();
  }

  void toggleFavoriteStatus() {
    // Toggle the isFavourite status of the found recipe
    model.isFavourite = !model.isFavourite;
    update(); // Assuming you're using GetX or a similar state management solution
  }

  void incrementQuantity() {
    quantity++;
    update();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      // Prevent quantity from going below 1
      quantity--;
      update(); // Notify listeners for UI update
    }
  }

  double getTotalPrice() {
    return model.price * quantity;
  }

  final List<String> tabs = <String>[
    "Nutrition",
    "Review",
  ];

  void onTapTabIndex(int index) {
    if (currentTabIndex == index) return;
    currentTabIndex = index;
    tabController.animateTo(
      index,
      curve: Curves.ease,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
    );
  }
}
