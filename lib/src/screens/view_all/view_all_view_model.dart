import 'package:get/get.dart';


import '../../constants/app_values.dart';
import '../../data/model/product/food_item_model.dart';
import '../../utils/utils.dart';
import '../../widgets/bottom_sheet/sort_bottom_sheet.dart';
import '../filter/filter_view.dart';
import '../filter/filter_view_model.dart';

class ViewAllViewModel extends GetxController {
  String currentSort = 'Relevance';

  void toggleFavoriteStatus(String id, List<FoodItemModel> recipeList) {
    int index = recipeList.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      // Toggle the isFavourite status of the found recipe
      recipeList[index].isFavourite = !recipeList[index].isFavourite;
      update(); // Assuming you're using GetX or a similar state management solution
    }
  }

  void onTapFilter() {
    Get.to(
      () => const FilterView(),
      fullscreenDialog: true,
      duration: const Duration(milliseconds: AppValues.defaultAnimationDuration,),
      transition: Transition.cupertinoDialog,
      binding: BindingsBuilder(
        () {
          Get.put(
            FilterViewModel(),
            permanent: true,
          );
        },
      ),
    );
  }

  void onSortBy() {
    Utils.getXBottomSheet(
      child: SortBottomSheet(
        currentSort: currentSort,
        onSelect: (value) {
          currentSort = value;
          update();
        },
      ),
    );
  }
}
