import 'package:get/get.dart';

class PreferenceOption {
  String name;
  RxBool isSelected;

  PreferenceOption({required this.name, bool isSelected = false})
      : isSelected = RxBool(isSelected);
}

class Preferences {
  RxList<PreferenceOption> cuisines;
  RxList<PreferenceOption> dietaryRestrictions;
  RxList<PreferenceOption> allergies;
  RxList<PreferenceOption> spices;
  RxList<PreferenceOption> cookingTimes;
  RxList<PreferenceOption> skillLevels;

  Preferences({
    required this.cuisines,
    required this.dietaryRestrictions,
    required this.allergies,
    required this.spices,
    required this.cookingTimes,
    required this.skillLevels,
  });

  factory Preferences.initial() {
    return Preferences(
      cuisines: RxList<PreferenceOption>(['Italian', 'Asian', 'Mexican', 'Indian', 'Mediterranean', 'American', 'Middle Eastern', 'Latin American'].map((c) => PreferenceOption(name: c)).toList()),
      dietaryRestrictions: RxList<PreferenceOption>(['Vegetarian', 'Vegan', 'Gluten-Free', 'Low-Carb', 'Low-Fat', 'Dairy-Free', 'Nut-Free', 'Pescatarian', 'Keto', 'Paleo', 'High-Protein'].map((r) => PreferenceOption(name: r)).toList()),
      allergies: RxList<PreferenceOption>(['Dairy', 'Nut', 'Seafood', 'Gluten', 'Soy', 'Egg'].map((a) => PreferenceOption(name: a)).toList()),
      spices: RxList<PreferenceOption>(['Mild', 'Medium', 'Spicy'].map((s) => PreferenceOption(name: s)).toList()),
      cookingTimes: RxList<PreferenceOption>(['15-30 mins', '30-45 mins', '45 mins & above'].map((t) => PreferenceOption(name: t)).toList()),
      skillLevels: RxList<PreferenceOption>(['Beginner', 'Intermediate', 'Advanced'].map((l) => PreferenceOption(name: l)).toList()),
    );
  }
}
