import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/product/food_item_model.dart';
import '../../search/search_view.dart';

class HomeViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late TabController tabController;
  int currentTabIndex = 0;

  double collapsedBarHeight = 60.0;
  double expandedBarHeight = 200.0;
  bool isCollapsed = false;
  bool didAddFeedback = false;
  late final User? user;

  List<FoodItemModel> popularRestaurantsList = [
    FoodItemModel(
      id: "001",
      title: "Spaghetti Carbonara",
      image: AppImages.noodles,
      price: 120,
      ratings: 4.5,
      description: "Classic creamy pasta with eggs and bacon.",
      restaurantName: "Spice Route",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "002",
      title: "Margherita Pizza",
      image: AppImages.noodles,
      price: 150,
      ratings: 4.7,
      description:
          "Traditional Italian pizza with fresh tomatoes, mozzarella, and basil.",
      restaurantName: "Kabbana",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "003",
      title: "Chicken Tikka Masala",
      image: AppImages.noodles,
      price: 130,
      ratings: 4.8,
      description: "Rich and creamy chicken in a spicy tomato sauce.",
      restaurantName: "Kababish",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "004",
      title: "Sushi Platter",
      image: AppImages.noodles,
      price: 200,
      ratings: 4.9,
      description: "Assorted sushi featuring salmon, tuna, and avocado.",
      restaurantName: "Spice Route",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "005",
      title: "Vegan Salad Bowl",
      image: AppImages.noodles,
      price: 110,
      ratings: 4.2,
      description:
          "A refreshing mix of organic greens, nuts, and fruits with a light vinaigrette.",
      restaurantName: "Akbar",
      isFavourite: true,
    )
  ];
  List<FoodItemModel> popularFoodList = [
    FoodItemModel(
      id: "101",
      title: "Macaroni and Cheese",
      image: AppImages.noodles,
      price: 100,
      ratings: 4.6,
      description: "Creamy, cheesy macaroni with a crispy breadcrumb topping.",
      restaurantName: "Dixy",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "102",
      title: "Beef Stew",
      image: AppImages.noodles,
      price: 180,
      ratings: 4.8,
      description:
          "Tender chunks of beef simmered with vegetables in a rich gravy.",
      restaurantName: "Spice Route",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "103",
      title: "Chicken Pot Pie",
      image: AppImages.noodles,
      price: 150,
      ratings: 4.7,
      description:
          "Flaky pie crust filled with creamy chicken and vegetable filling.",
      restaurantName: "Spice Route",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "104",
      title: "Shepherd’s Pie",
      image: AppImages.noodles,
      price: 160,
      ratings: 4.5,
      description:
          "Savory ground lamb topped with a layer of crispy mashed potatoes.",
      restaurantName: "Spice Route",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "105",
      title: "Lasagna",
      image: AppImages.noodles,
      price: 140,
      ratings: 4.9,
      description: "Layers of pasta, meat sauce, and melted cheeses.",
      restaurantName: "Dixy",
      isFavourite: false,
    )
  ];

  final List<String> tabs = <String>[
    "Main Courses",
    "Appetizers",
    "Side Dishes",
    "Desserts",
    "Beverages",
  ];

  void onTapTabIndex(int index) {
    if (currentTabIndex == index) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      update(); // Schedule the update to happen after the current frame
    });
    currentTabIndex = index;
    tabController.animateTo(
      index,
      curve: Curves.ease,
      duration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    );
  }

  bool onNotification(Notification notification) {
    bool newIsCollapsed = scrollController.hasClients &&
        scrollController.offset > (expandedBarHeight - collapsedBarHeight);
    if (newIsCollapsed != isCollapsed) {
      isCollapsed = newIsCollapsed;
      if (isCollapsed && !didAddFeedback) {
        HapticFeedback.mediumImpact();
        didAddFeedback = true;
      } else if (!isCollapsed && didAddFeedback) {
        didAddFeedback = false;
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        update(); // Schedule the update to happen after the current frame
      });
    }
    return false;
  }

  void toggleFavoriteStatus(String id, List<FoodItemModel> recipeList) {
    int index = recipeList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      // Toggle the isFavourite status of the found recipe
      recipeList[index].isFavourite = !recipeList[index].isFavourite;
      update(); // Assuming you're using GetX or a similar state management solution
    }
  }
  void searchOnTap(){
    Get.toNamed(SearchView.id,);
  }

  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    _getUser();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void _getUser() {
    user = FirebaseAuth.instance.currentUser;
  }
}
