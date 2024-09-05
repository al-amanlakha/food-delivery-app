import 'package:get/get.dart';

import '../../../data/model/product/nutrition.dart';

class NutritionViewModel extends GetxController{
  List<Nutrition> nutritionList =  [
    Nutrition(
      name: 'Calories',
      quantity: '200 kcal',
      dailyValue: 10.0,
    ),
    Nutrition(
      name: 'Fat',
      quantity: '9 g',
      dailyValue: 14.0,
    ),
    Nutrition(
      name: 'Sodium',
      quantity: '200 mg',
      dailyValue: 9.0,
    ),
    Nutrition(
      name: 'Protein',
      quantity: '5 g',
      dailyValue: 10.0,
    ),
    Nutrition(
      name: 'Carbohydrates',
      quantity: '28 g',
      dailyValue: 9.0,
    ),
    Nutrition(
      name: 'Fiber',
      quantity: '3 g',
      dailyValue: 12.0,
    ),
    Nutrition(
      name: 'Sugar',
      quantity: '12 g',
      dailyValue: 12.0,
    ),
  ];
}