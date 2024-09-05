class Ingredient {
  final String name;
  final String image;
  final String quantity;  // Using String to accommodate units (e.g., "1 cup", "2 tablespoons")

  Ingredient({
    required this.name,
    required this.image,
    required this.quantity,
  });

  // Optionally, you can add a method to create an Ingredient from a map (useful for JSON parsing if needed)
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  // Method to convert the ingredient to a JSON-like map (useful for serialization)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'quantity': quantity,
    };
  }
}
