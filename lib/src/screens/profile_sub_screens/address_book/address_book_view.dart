import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/address/address_model.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import 'address_book_view_model.dart';

class AddressBookView extends StatelessWidget {
  const AddressBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressBookViewModel>(
      builder: (controller) {
        final AddressModel? model = controller.userAddress;
        return Scaffold(
          appBar: const SubProfileAppBar(
            title: AppStrings.addressBook,
          ),
          body: SingleChildScrollView(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.defaultDeliveryAddress,
                  style: AppTextStyles.text2.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
                defaultHeightSpacing,
                if (model != null)
                  IntrinsicHeight(
                    child: Card(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppValues.radius30,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(AppValues.padding16),
                              child: Text(
                                model.completeAddress!,
                                style: AppTextStyles.text1,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: AppValues.margin4,
                          ),
                          InkWell(
                            onTap: controller.onEditTap,
                            child: Container(
                              padding: const EdgeInsets.all(
                                AppValues.padding8,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    AppValues.radius30,
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                defaultHeightSpacing,
                InkWell(
                  onTap: controller.onAddNewAddress,
                  child: Text(
                    AppStrings.addNewAddress,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
