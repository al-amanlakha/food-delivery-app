import 'package:flutter/material.dart';
import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/widgets/loader/generic_loader.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_paddings.dart';
import '../../../../constants/app_strings.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/app_values.dart';
import '../../../../utils/global_utils.dart';
import '../../../../widgets/buttons/generic_button.dart';
import '../../../../widgets/profile/sub_profile_app_bar.dart';
import '../../../../widgets/textfield/generic_textfield.dart';
import 'add_address_view_model.dart';

class AddAddressView extends StatelessWidget {
  final String title;

  const AddAddressView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressViewModel>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              return;
            }
            controller.onBackTap();
          },
          child: AbsorbPointer(
            absorbing: controller.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  title,
                  style: AppTextStyles.heading2,
                ),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: controller.onAllowAccessToLocation,
                    icon: const PhosphorIcon(
                      PhosphorIconsRegular.mapPin,
                      color: AppColors.blackishGrey,
                      size: AppValues.iconSize,
                    ),
                  ),
                ],
              ),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    padding: AppPaddings.defaultPaddingAll,
                    child: Form(
                      // Wrap with Form widget
                      key: controller.formKey,
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
                              validator: (value) =>
                                  controller.validateOnlyLetters(value, 'City'),
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
                              validator: (value) => controller
                                  .validateOnlyLetters(value, 'County'),
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
                              validator: (value) => controller
                                  .validateOnlyLetters(value, 'Country'),
                            ),
                          ),
                          defaultHeightSpacing,
                          getLabeledTextField(
                            title: AppStrings.postCode,
                            child: GenericTextField(
                              controller: controller.postCode,
                              textInputAction: TextInputAction.done,
                              hintText: AppStrings.postCodeHint,
                              validator: controller.validatePostCode,
                              inputFormatters: [
                                PostCodeInputFormatter(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  controller.isLoading
                      ? const Center(
                          child: GenericLoader(),
                        )
                      : const SizedBox.shrink()
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
                      onPressed: controller.isDataChanged
                          ? controller.onTapSaveThisAddress
                          : null,
                      title: Text(
                        AppStrings.save,
                        style: AppTextStyles.title
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
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
