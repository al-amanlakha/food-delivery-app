import 'package:get/get.dart';

import '../../../../../constants/app_images.dart';
import '../../../../../data/model/product/food_item_model.dart';

class MainCourseViewModel extends GetxController {
  List<FoodItemModel> mainCourseList = [
    FoodItemModel(
      id: "201",
      title: "Grilled Salmon with Asparagus",
      image: AppImages.noodles,
      price: 220,
      ratings: 4.6,
      description: "Fresh salmon fillet grilled to perfection served with steamed asparagus.",
      restaurantName: "Kabbana",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "202",
      title: "Beef Bourguignon",
      image: AppImages.noodles,
      price: 250,
      ratings: 4.8,
      description: "Slow-cooked beef in red wine with mushrooms, carrots, and onions.",
      restaurantName: "Kabbana",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "203",
      title: "Chicken Parmesan",
      image: AppImages.noodles,
      price: 160,
      ratings: 4.7,
      description: "Breaded chicken breast topped with marinara sauce and melted cheese.",
      restaurantName: "Kabbana",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "204",
      title: "Vegetable Stir Fry",
      image: AppImages.noodles,
      price: 120,
      ratings: 4.5,
      description: "A medley of fresh vegetables sautéed with soy sauce and sesame seeds.",
      restaurantName: "Spice Route",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "205",
      title: "Lamb Rogan Josh",
      image: AppImages.noodles,
      price: 240,
      ratings: 4.9,
      description: "Tender lamb cooked in a spiced tomato and yogurt sauce.",
      restaurantName: "Italian",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "206",
      title: "Spaghetti Bolognese",
      image: AppImages.noodles,
      price: 130,
      ratings: 4.3,
      description: "Classic Italian pasta with a hearty meat sauce.",
      restaurantName: "Italian",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "207",
      title: "Pork Schnitzel",
      image: AppImages.noodles,
      price: 180,
      ratings: 4.4,
      description: "Crispy breaded pork cutlet served with lemon wedges.",
      restaurantName: "Kabbana",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "208",
      title: "Thai Green Curry",
      image: AppImages.noodles,
      price: 150,
      ratings: 4.7,
      description: "Spicy green curry with chicken, bamboo shoots, and basil.",
      restaurantName: "Kababish",
      isFavourite: true,
    )
  ];

  void toggleFavoriteStatus(String id) {
    int index = mainCourseList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      mainCourseList[index].isFavourite =
      !mainCourseList[index].isFavourite;
      update(); // This will trigger a UI update
    }
  }
}