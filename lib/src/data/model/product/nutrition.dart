class Nutrition {
  final String name;
  final String quantity;  // Represents the amount of the nutrient
  final double dailyValue;  // Represents the percentage of the daily recommended intake

  Nutrition({
    required this.name,
    required this.quantity,
    required this.dailyValue,
  });

  // Optionally, add a method to create a Nutrition from a map (useful for JSON parsing)
  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      name: json['name'],
      quantity: json['quantity'],
      dailyValue: json['dailyValue'],
    );
  }

  // Method to convert the nutrition to a JSON-like map (useful for serialization)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'dailyValue': dailyValue,
    };
  }
}
