import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/product/food_item_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/bottom_sheet/sort_bottom_sheet.dart';
import '../../filter/filter_view.dart';
import '../../filter/filter_view_model.dart';

class SearchResultsViewModel extends GetxController {
  final searchController = TextEditingController();
  bool isTextEmpty = true;
  String currentSort = 'Relevance';

  List<FoodItemModel> searchResults = [
    FoodItemModel(
      id: "001",
      title: "Spaghetti Carbonara",
      image: AppImages.noodles,
      price: 120,
      ratings: 4.5,
      description: "Classic creamy pasta with eggs and bacon.",
      restaurantName: "La Dolce Vita",
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

  void toggleFavoriteStatus(String id, List<FoodItemModel> recipeList) {
    int index = recipeList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      // Toggle the isFavourite status of the found recipe
      recipeList[index].isFavourite = !recipeList[index].isFavourite;
      update(); // Assuming you're using GetX or a similar state management solution
    }
  }

  @override
  void onInit() {
    _loadArguments();
    searchController.addListener(_searchTextListener);
    super.onInit();
  }

  void _loadArguments() {
    final String? args = Get.arguments as String?;

    if (args != null) {
      searchController.text = args;
    }
  }

  _searchTextListener() {
    isTextEmpty = searchController.text.isEmpty;
    update();
  }

  void clearSearchField() {
    searchController.clear();
  }

  void onTapFilter() {
    Get.to(
      () => const FilterView(),
      fullscreenDialog: true,
      duration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
      transition: Transition.cupertinoDialog,
      binding: BindingsBuilder(
        () {
          Get.put(
            FilterViewModel(),
            permanent: true,
          );
        },
      ),
    );
  }

  void onSortBy() {
    Utils.getXBottomSheet(
      child: SortBottomSheet(
        currentSort: currentSort,
        onSelect: (value) {
          currentSort = value;
          update();
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.removeListener(_searchTextListener);
    searchController.dispose();
    super.dispose();
  }
}
