import 'package:get/get.dart';

import '../../../../../constants/app_images.dart';
import '../../../../../data/model/product/food_item_model.dart';

class DessertsViewModel extends GetxController {
  List<FoodItemModel> dessertList = [
    FoodItemModel(
      id: "501",
      title: "Chocolate Lava Cake",
      image: AppImages.noodles,
      price: 90,
      ratings: 4.9,
      description: "Rich chocolate cake with a gooey molten chocolate center.",
      restaurantName: "Dixy",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "502",
      title: "Tiramisu",
      image: AppImages.noodles,
      price: 100,
      ratings: 4.8,
      description: "Classic Italian dessert with layers of coffee-soaked ladyfingers and mascarpone cheese.",
      restaurantName: "Kabbana",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "503",
      title: "Apple Pie",
      image: AppImages.noodles,
      price: 75,
      ratings: 4.7,
      description: "Traditional apple pie with a flaky crust and spiced apple filling.",
      restaurantName: "La Carte",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "504",
      title: "Lemon Meringue Pie",
      image: AppImages.noodles,
      price: 85,
      ratings: 4.5,
      description: "Tart lemon filling topped with a fluffy, toasted meringue.",
      restaurantName: "La Carte",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "505",
      title: "Cheesecake",
      image: AppImages.noodles,
      price: 95,
      ratings: 4.6,
      description: "Creamy cheesecake on a graham cracker crust with a fruit topping.",
      restaurantName: "La Carte",
      isFavourite: true,
    )
  ];

  void toggleFavoriteStatus(String id) {
    int index = dessertList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      dessertList[index].isFavourite =
      !dessertList[index].isFavourite;
      update(); // This will trigger a UI update
    }
  }
}