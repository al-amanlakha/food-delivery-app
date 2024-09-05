import 'package:get/get.dart';

import '../../../../../constants/app_images.dart';
import '../../../../../data/model/product/food_item_model.dart';

class BeveragesViewModel extends GetxController {
  List<FoodItemModel> beverageList = [
    FoodItemModel(
      id: "601",
      title: "Classic Mojito",
      image: AppImages.noodles,
      price: 50,
      ratings: 4.7,
      description: "Refreshing mix of white rum, sugar, lime juice, soda water, and mint.",
      restaurantName: "Dixy",
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
      isFavourite: false,
    ),
    FoodItemModel(
      id: "603",
      title: "Mango Smoothie",
      image: AppImages.noodles,
      price: 40,
      ratings: 4.9,
      description: "A thick blend of mangoes, yogurt, and a touch of honey.",
      restaurantName: "Dixy",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "604",
      title: "Pomegranate Spritzer",
      image: AppImages.noodles,
      price: 55,
      ratings: 4.6,
      description: "A fizzy, fruity drink with pomegranate juice, sparkling water, and lime.",
      restaurantName: "Dixy",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "605",
      title: "Espresso Martini",
      image: AppImages.noodles,
      price: 60,
      ratings: 4.8,
      description: "Vodka, coffee liqueur, and fresh espresso shaken to a frothy finish.",
      restaurantName: "Bar",
      isFavourite: true,
    )
  ];

  void toggleFavoriteStatus(String id) {
    int index = beverageList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      beverageList[index].isFavourite =
      !beverageList[index].isFavourite;
      update(); // This will trigger a UI update
    }
  }
}