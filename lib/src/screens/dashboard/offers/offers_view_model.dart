import 'package:food_delivery/src/constants/app_images.dart';
import 'package:food_delivery/src/data/model/product/food_item_model.dart';
import 'package:get/get.dart';

class OffersViewModel extends GetxController {
  List<FoodItemModel> offersList = [
    FoodItemModel(
      id: '1',
      title: 'Margherita Pizza',
      image: AppImages.noodles,
      price: 8.99,
      ratings: 4.7,
      isFavourite: false,
      description: 'Classic pizza with fresh mozzarella, tomatoes, and basil.',
      restaurantName: 'Bella Italia',
    ),
    FoodItemModel(
      id: '2',
      title: 'BBQ Chicken Burger',
      image: AppImages.noodles,
      price: 5.99,
      ratings: 4.5,
      isFavourite: true,
      description: 'Grilled chicken burger with tangy BBQ sauce and lettuce.',
      restaurantName: 'Grill House',
    ),
    FoodItemModel(
      id: '3',
      title: 'Vegan Tacos',
      image: AppImages.noodles,
      price: 6.49,
      ratings: 4.8,
      isFavourite: false,
      description: 'Tacos with plant-based filling, avocado, and salsa.',
      restaurantName: 'Green Eats',
    ),
    FoodItemModel(
      id: '4',
      title: 'Spicy Tuna Roll',
      image: AppImages.noodles,
      price: 9.99,
      ratings: 4.6,
      isFavourite: true,
      description: 'Fresh sushi rolls filled with spicy tuna and avocado.',
      restaurantName: 'Sushi Haven',
    ),
    FoodItemModel(
      id: '5',
      title: 'Pad Thai',
      image: AppImages.noodles,
      price: 7.99,
      ratings: 4.9,
      isFavourite: false,
      description: 'Stir-fried noodles with shrimp, tofu, peanuts, and tamarind sauce.',
      restaurantName: 'Thai Express',
    ),
    FoodItemModel(
      id: '6',
      title: 'Double Chocolate Brownie',
      image: AppImages.noodles,
      price: 3.49,
      ratings: 4.8,
      isFavourite: true,
      description: 'Rich, fudgy brownie made with dark chocolate and walnuts.',
      restaurantName: 'Sweet Treats',
    ),
    FoodItemModel(
      id: '7',
      title: 'Caesar Salad',
      image: AppImages.noodles,
      price: 4.99,
      ratings: 4.2,
      isFavourite: false,
      description: 'Crisp romaine lettuce, parmesan, croutons, and Caesar dressing.',
      restaurantName: 'Healthy Bites',
    ),
    FoodItemModel(
      id: '8',
      title: 'Chicken Biryani',
      image: AppImages.noodles,
      price: 10.99,
      ratings: 4.9,
      isFavourite: true,
      description: 'Fragrant basmati rice and tender chicken, cooked with Indian spices.',
      restaurantName: 'Spice World',
    ),
  ];
}