import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/model/filter/filter_options.dart';
import '../../widgets/dialogs/clear_filter_dialog.dart';

class FilterViewModel extends GetxController {
  final RxList<FilterOption> filterOptions = <FilterOption>[
    FilterOption(
      name: 'Cuisine',
      options: ['Italian', 'Chinese', 'Indian', 'Mexican', 'Japanese', 'American', 'Thai', 'Mediterranean'],
    ),
    FilterOption(
      name: 'Price Range',
      options: ['\$ (Low)', '\$\$ (Moderate)', '\$\$\$ (High)', '\$\$\$\$ (Premium)'],
    ),
    FilterOption(
      name: 'Delivery Time',
      options: ['Under 30 minutes', '30-45 minutes', '45-60 minutes', '1 hour or more'],
    ),
    FilterOption(
      name: 'Rating',
      options: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
    ),
    FilterOption(
      name: 'Dietary Preferences',
      options: ['Vegetarian', 'Vegan', 'Gluten-Free', 'Halal', 'Kosher'],
    ),
    FilterOption(
      name: 'Meal Type',
      options: ['Breakfast', 'Lunch', 'Dinner', 'Snacks', 'Desserts'],
    ),
    FilterOption(
      name: 'Distance',
      options: ['Within 5 km', 'Within 10 km', 'Within 20 km'],
    ),
    FilterOption(
      name: 'Special Offers',
      options: ['Free Delivery', 'Discounts', 'Buy 1 Get 1 Free'],
    ),
    FilterOption(
      name: 'Restaurant Rating',
      options: ['4 Stars & Up', '3 Stars & Up', '2 Stars & Up'],
    ),
    FilterOption(
      name: 'Payment Method',
      options: ['Cash', 'Credit/Debit Card', 'Mobile Payments', 'Digital Wallets'],
    ),
  ].obs;

  // Map to keep track of which filters are expanded
  RxMap<String, bool> expandedTiles = <String, bool>{}.obs;

  // Map to keep track of selected filters by category
  RxMap<String, Set<String>> selectedFilters = <String, Set<String>>{}.obs;

  // Function to toggle the expansion state of a tile
  void toggleTile(String category) {
    expandedTiles[category] = !(expandedTiles[category] ?? false);
  }

  // Function to update filter selection
  void updateFilter(String category, String filter, bool isSelected) {
    final filters = selectedFilters[category] ?? <String>{};
    if (isSelected) {
      filters.add(filter);
    } else {
      filters.remove(filter);
    }
    selectedFilters[category] = filters;
  }

  void clearAllFilters() {
    if (selectedFilters.entries.any((entry) => entry.value.isNotEmpty)) {
      Get.dialog(
        ClearFilterDialog(
          onClearAll: () {
            selectedFilters.clear();
            Get.back();
          },
        ),
      );
    }
  }

  void applyFilters() {
    if (selectedFilters.entries.any((entry) => entry.value.isNotEmpty)) {
      selectedFilters.forEach((category, filters) {
        if (filters.isNotEmpty) {
          if (kDebugMode) {
            print('$category: $filters');
          }
        }
      });
      // Optional: Add any actions to take after applying filters, like navigating or updating a list.
      Get.back(); // Comment or remove if you don't want to close the filter view after applying
    }
  }

  @override
  void dispose() {
    selectedFilters.close();
    expandedTiles.close();
    filterOptions.close();
    super.dispose();
  }
}
