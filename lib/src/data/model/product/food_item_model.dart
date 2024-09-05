class FoodItemModel {
  final String id;
  bool isFavourite;
  final String title;
  final String image;
  final double price;
  final double ratings;
  final String description;
  final String restaurantName;

  FoodItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.ratings,
    this.isFavourite = false,
    required this.description,
    required this.restaurantName,
  });
}