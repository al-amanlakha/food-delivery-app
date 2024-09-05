import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_view_model.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../../widgets/buttons/generic_button.dart';


class FilterView extends GetView<FilterViewModel> {
  static const String id = "/FILTER_VIEW";

  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientColor2,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close,
            color: AppColors.white,
          ),
        ),
        title: Text(
          AppStrings.filter,
          style: AppTextStyles.heading2.copyWith(color: AppColors.white),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.filterOptions.length,
        itemBuilder: (context, index) {
          final filterOption = controller.filterOptions[index];
          return Obx(
            () => ExpansionTile(
              tilePadding: AppPaddings.defaultPaddingHorizontal,
              childrenPadding: AppPaddings.defaultPaddingHorizontal,
              shape: const BeveledRectangleBorder(
                side: BorderSide.none,
              ),
              title: Text(
                filterOption.name,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              initiallyExpanded:
                  controller.expandedTiles[filterOption.name] ?? false,
              onExpansionChanged: (isExpanded) =>
                  controller.toggleTile(filterOption.name),
              children: filterOption.options.map((filter) {
                return Obx(
                  () {
                    final isSelected = controller
                            .selectedFilters[filterOption.name]
                            ?.contains(filter) ??
                        false;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        filter,
                        style: AppTextStyles.text2,
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppValues.radius8),
                          color: isSelected ? AppColors.orange : null,
                          border:
                              Border.all(color: AppColors.orange, width: 1),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                size: 16, color: AppColors.white)
                            : null,
                      ),
                      onTap: () => controller.updateFilter(
                          filterOption.name, filter, !isSelected),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppValues.defaultPadding,
            vertical: AppValues.padding10,
          ),
          color: AppColors.warmWhite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GenericButton(
                      onPressed: controller.clearAllFilters,
                      height: 48,
                      isBorder: true,
                      color: Colors.transparent,
                      title: const Text(
                        AppStrings.clearAll,
                        style: AppTextStyles.title,
                      ),
                    ),
                  ),
                  defaultWidthSpacing,
                  Expanded(
                    child: GenericButton(
                      onPressed: controller.selectedFilters.entries
                              .any((entry) => entry.value.isNotEmpty)
                          ? controller.applyFilters
                          : null,
                      height: 48,
                      title: Text(
                        AppStrings.apply,
                        style: AppTextStyles.title.copyWith(
                          color:AppColors.white, // Dim the text if disabled
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
