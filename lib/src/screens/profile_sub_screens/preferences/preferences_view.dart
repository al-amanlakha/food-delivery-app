import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/preferences/preference_option.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import 'preferences_view_model.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferencesViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: const SubProfileAppBar(
            title: AppStrings.preferences,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: AppValues.defaultPadding,
            ),
            children: [
              buildSelectionSection("What are your favorite cuisines?",
                  controller.preferences.value.cuisines),
              buildSelectionSection("Do you have any dietary restrictions?",
                  controller.preferences.value.dietaryRestrictions),
              buildSelectionSection("Do you have any allergies?",
                  controller.preferences.value.allergies),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.defaultPadding,
              vertical: AppValues.padding10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GenericButton(
                  onPressed: controller.onTapSaveMyPreference,
                  title: Text(
                    AppStrings.saveMyPreference,
                    style: AppTextStyles.title.copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSelectionSection(String title, List<PreferenceOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppValues.padding16,
            vertical: AppValues.padding8,
          ),
          child: Text(
            title,
            style: AppTextStyles.text1.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        ...options.map(
          (option) => Obx(
            () => CheckboxListTile(
              activeColor: AppColors.orange,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppValues.radius12,
                ),
              ),
              side: const BorderSide(
                color: AppColors.blackishGrey,
              ),
              title: Text(
                option.name,
                style: AppTextStyles.text2,
              ),
              value: option.isSelected.value,
              onChanged: (bool? value) {
                if (value != null) {
                  option.isSelected.value = value;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
