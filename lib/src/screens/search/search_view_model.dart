import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../constants/app_images.dart';
import '../../constants/app_values.dart';
import '../../data/model/recipe/recipe_model.dart';
import 'search_result_view/search_results_view.dart';
import 'search_result_view/search_results_view_model.dart';

class SearchViewModel extends GetxController {
  final TextEditingController searchController = TextEditingController();
  List<Recipe> filteredSearchResults = [];

  final List<Recipe> popularRecipes = [
    Recipe(
      recipeId: '1',
      recipeName: 'Spaghetti Carbonara',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '2',
      recipeName: 'Chicken Tikka Masala',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '3',
      recipeName: 'Cheeseburger',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '4',
      recipeName: 'Caesar Salad',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '5',
      recipeName: 'Chocolate Cake',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '6',
      recipeName: 'Sushi Rolls',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '7',
      recipeName: 'Tacos',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '8',
      recipeName: 'Caprese Salad',
      recipeImage: AppImages.noodles,
    ),
  ];
  final List<Recipe> recentSearches = [
    Recipe(
      recipeId: '1',
      recipeName: 'Spaghetti Carbonara',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '2',
      recipeName: 'Chicken Tikka Masala',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '3',
      recipeName: 'Cheeseburger',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '4',
      recipeName: 'Caesar Salad',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '5',
      recipeName: 'Chocolate Cake',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '6',
      recipeName: 'Sushi Rolls',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '7',
      recipeName: 'Tacos',
      recipeImage: AppImages.noodles,
    ),
    Recipe(
      recipeId: '8',
      recipeName: 'Caprese Salad',
      recipeImage: AppImages.noodles,
    ),
  ];
  bool isTextEmpty = true;

  int currentIndex = 0;

  _searchTextListener() {
    isTextEmpty = searchController.text.isEmpty;
    filterSearchResults(searchController.text); // Filter results based on the input
    if (searchController.text.isNotEmpty) {
      currentIndex = 1;
    } else {
      currentIndex = 0;
    }
    update(); // Calls update to rebuild the GetBuilder widgets
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredSearchResults = recentSearches; // Show all if no query
    } else {
      filteredSearchResults = recentSearches.where((recipe) {
        // Filter list based on the query, case insensitive
        return recipe.recipeName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void onSearchSubmit(String val) {
    if (searchController.text.isNotEmpty) {
      Get.to(
        () => const SearchResultsView(),
        curve: Curves.ease,
        transition: Transition.cupertino,
        duration:
            const Duration(milliseconds: AppValues.defaultAnimationDuration),
        arguments: val,
        binding: BindingsBuilder(
          () => Get.lazyPut(
            () => SearchResultsViewModel(),
            fenix: true,
          ),
        ),
      );
    }
  }

  void clearSearchField() {
    searchController.clear();
  }

  @override
  void onInit() {
    searchController.addListener(_searchTextListener);
    super.onInit();
  }

  @override
  void dispose() {
    searchController.removeListener(_searchTextListener);
    searchController.dispose();
    super.dispose();
  }
}
