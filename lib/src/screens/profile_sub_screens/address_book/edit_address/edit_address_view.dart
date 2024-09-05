import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../constants/app_colors.dart';
import '../../../../constants/app_paddings.dart';
import '../../../../constants/app_strings.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/app_values.dart';
import '../../../../utils/global_utils.dart';
import '../../../../widgets/buttons/generic_button.dart';
import '../../../../widgets/profile/sub_profile_app_bar.dart';
import '../../../../widgets/textfield/generic_textfield.dart';
import 'edit_address_view_model.dart';

class EditAddressView extends StatelessWidget {
  final String title;

  const EditAddressView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAddressViewModel>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if(didPop) {
              return;
            }
            controller.onBackTap();
          },
          child: Scaffold(
            appBar: SubProfileAppBar(
              title: title,
              onTap: controller.onBackTap,
            ),
            body: SingleChildScrollView(
              padding: AppPaddings.defaultPaddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getLabeledTextField(
                    title: AppStrings.addressLine1,
                    child: GenericTextField(
                      controller: controller.addressLine1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      hintText: '',
                    ),
                  ),
                  defaultHeightSpacing,
                  getLabeledTextField(
                    title: AppStrings.addressLine2,
                    child: GenericTextField(
                      controller: controller.addressLine2,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      hintText: '',
                    ),
                  ),
                  defaultHeightSpacing,
                  getLabeledTextField(
                    title: AppStrings.city,
                    child: GenericTextField(
                      controller: controller.city,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      hintText: AppStrings.cityHint,
                    ),
                  ),
                  defaultHeightSpacing,
                  getLabeledTextField(
                    title: AppStrings.county,
                    child: GenericTextField(
                      controller: controller.county,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      hintText: AppStrings.countyHint,
                    ),
                  ),
                  defaultHeightSpacing,
                  getLabeledTextField(
                    title: AppStrings.country,
                    child: GenericTextField(
                      controller: controller.country,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      hintText: AppStrings.countryHint,
                    ),
                  ),
                  defaultHeightSpacing,
                  getLabeledTextField(
                    title: AppStrings.postCode,
                    child: GenericTextField(
                      controller: controller.postCode,
                      textInputAction: TextInputAction.done,
                      hintText: AppStrings.postCodeHint,
                    ),
                  ),
                ],
              ),
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
                    onPressed: controller.isDataChanged ? controller.onTapSaveThisAddress : null,
                    title: Text(
                      AppStrings.saveThisAddress,
                      style: AppTextStyles.title.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getLabeledTextField({
    required String title,
    required GenericTextField child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.text2.copyWith(
            color: AppColors.grey,
          ),
        ),
        const SizedBox(
          height: AppValues.margin4,
        ),
        child
      ],
    );
  }
}
