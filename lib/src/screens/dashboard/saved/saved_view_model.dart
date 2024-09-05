import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../data/model/product/food_item_model.dart';

class SavedViewModel extends GetxController {
  List<FoodItemModel> favoriteRecipes = [
    FoodItemModel(
      id: "601",
      title: "Classic Mojito",
      image: AppImages.noodles,
      price: 50,
      ratings: 4.7,
      description: "Refreshing mix of white rum, sugar, lime juice, soda water, and mint.",
      restaurantName: "DoDurga",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "602",
      title: "Iced Matcha Latte",
      image: AppImages.noodles,
      price: 45,
      ratings: 4.5,
      description: "Creamy and sweet matcha tea blended with milk and ice.",
      restaurantName: "Top Taste",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "603",
      title: "Mango Smoothie",
      image: AppImages.noodles,
      price: 40,
      ratings: 4.9,
      description: "A thick blend of mangoes, yogurt, and a touch of honey.",
      restaurantName: "DoDurga",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "604",
      title: "Pomegranate Spritzer",
      image: AppImages.noodles,
      price: 55,
      ratings: 4.6,
      description: "A fizzy, fruity drink with pomegranate juice, sparkling water, and lime.",
      restaurantName: "DoDurga",
      isFavourite: true,
    ),
  ];

  // Function to add or remove an item from the favorites
  void toggleFavoriteStatus(String id, List<FoodItemModel> recipeList) {
    int index = recipeList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      FoodItemModel recipe = recipeList[index];
      recipe.isFavourite = !recipe.isFavourite;
      if (recipe.isFavourite) {
        // Add to favorites if not already in list
        if (!favoriteRecipes.contains(recipe)) {
          favoriteRecipes.add(recipe);
        }
      } else {
        // Remove from favorites if it exists
        favoriteRecipes.remove(recipe);
      }
      update(); // Update the UI or notify listeners
    }
  }
}