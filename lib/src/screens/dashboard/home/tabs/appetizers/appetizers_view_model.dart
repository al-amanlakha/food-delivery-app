import 'package:get/get.dart';

import '../../../../../constants/app_images.dart';
import '../../../../../data/model/product/food_item_model.dart';

class AppetizersViewModel extends GetxController {
  List<FoodItemModel> appetizerList = [
    FoodItemModel(
      id: "301",
      title: "Bruschetta",
      image: AppImages.noodles,
      price: 80,
      ratings: 4.5,
      description: "Toasted bread slices topped with a mixture of chopped tomatoes, basil, and garlic.",
      restaurantName: "Akbar",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "302",
      title: "Chicken Satay",
      image: AppImages.noodles,
      price: 90,
      ratings: 4.6,
      description: "Grilled chicken skewers served with a creamy peanut sauce.",
      restaurantName: "Spice Route",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "303",
      title: "Shrimp Cocktail",
      image: AppImages.noodles,
      price: 120,
      ratings: 4.7,
      description: "Chilled shrimp served with a tangy cocktail sauce.",
      restaurantName: "Top Taste",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "304",
      title: "Stuffed Mushrooms",
      image: AppImages.noodles,
      price: 100,
      ratings: 4.8,
      description: "Mushroom caps filled with a savory blend of cheese and herbs.",
      restaurantName: "Kabbana",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "305",
      title: "Garlic Knots",
      image: AppImages.noodles,
      price: 70,
      ratings: 4.3,
      description: "Soft bread knots flavored with garlic butter and parsley.",
      restaurantName: "Spice Route",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "306",
      title: "Falafel",
      image: AppImages.noodles,
      price: 85,
      ratings: 4.9,
      description: "Deep-fried balls made from ground chickpeas and spices, served with tahini sauce.",
      restaurantName: "Dixy",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "307",
      title: "Caprese Salad",
      image: AppImages.noodles,
      price: 95,
      ratings: 4.4,
      description: "Slices of fresh mozzarella and tomatoes, seasoned with basil and olive oil.",
      restaurantName: "Top Taste",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "308",
      title: "Panko Crusted Calamari",
      image: AppImages.noodles,
      price: 110,
      ratings: 4.5,
      description: "Crispy calamari rings coated in panko breadcrumbs, served with a side of marinara sauce.",
      restaurantName: "Spice Route",
      isFavourite: true,
    )
  ];
  void toggleFavoriteStatus(String id) {
    int index = appetizerList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      appetizerList[index].isFavourite =
      !appetizerList[index].isFavourite;
      update(); // This will trigger a UI update
    }
  }
}