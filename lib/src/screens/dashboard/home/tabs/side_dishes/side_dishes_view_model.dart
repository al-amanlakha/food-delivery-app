import 'package:get/get.dart';

import '../../../../../constants/app_images.dart';
import '../../../../../data/model/product/food_item_model.dart';

class SideDishesViewModel extends GetxController {
  List<FoodItemModel> sideDishList = [
    FoodItemModel(
      id: "401",
      title: "Garlic Mashed Potatoes",
      image: AppImages.noodles,
      price: 50,
      ratings: 4.6,
      description: "Creamy mashed potatoes with a rich garlic flavor.",
      restaurantName: "DoDurga",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "402",
      title: "Sauteed Green Beans",
      image: AppImages.noodles,
      price: 40,
      ratings: 4.7,
      description: "Fresh green beans lightly sautéed with garlic and almonds.",
      restaurantName: "Spice Route",
      isFavourite: true,
    ),
    FoodItemModel(
      id: "403",
      title: "Coleslaw",
      image: AppImages.noodles,
      price: 30,
      ratings: 4.5,
      description: "Crisp cabbage and carrot slaw with a sweet and tangy dressing.",
      restaurantName: "Akbar",
      isFavourite: false,
    ),
    FoodItemModel(
      id: "404",
      title: "Roasted Brussels Sprouts",
      image: AppImages.noodles,
      price: 45,
      ratings: 4.8,
      description: "Brussels sprouts roasted with balsamic vinegar and honey.",
      restaurantName: "Kababish",
      isFavourite: true,
    )
  ];

  void toggleFavoriteStatus(String id) {
    int index = sideDishList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      sideDishList[index].isFavourite =
      !sideDishList[index].isFavourite;
      update(); // This will trigger a UI update
    }
  }
}