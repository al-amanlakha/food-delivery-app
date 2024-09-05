class Recipe {
  final String recipeId;
  final String recipeName;
  final String? recipeImage;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    this.recipeImage,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['id'],
      recipeName: json['name'],
      recipeImage: json['image'],
    );
  }
}
