import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../../widgets/buttons/generic_button.dart';
import '../../widgets/cart/checkout_radio_tile.dart';
import '../../widgets/profile/sub_profile_app_bar.dart';
import 'checkout_view_model.dart';


class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: const SubProfileAppBar(
            title: AppStrings.checkout,
          ),
          body: SingleChildScrollView(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.deliveryAddress,
                        style: AppTextStyles.text1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: controller.onChange,
                      child: Text(
                        AppStrings.change,
                        style: AppTextStyles.text1.copyWith(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                defaultWidthSpacing,
                ...controller.addresses.map(
                  (address) => CheckoutRadioTile(
                    key: ValueKey(address),
                    title: address,
                    isAddress: true,
                    trailing: Radio<String>(
                      value: address,
                      activeColor: AppColors.orange,
                      groupValue: controller.selectedAddress,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectAddress(value);
                        }
                      },
                    ),
                  ),
                )..toList(),
                defaultHeightSpacing,
                defaultHeightSpacing,
                Text(
                  AppStrings.timing,
                  style: AppTextStyles.text1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                defaultHeightSpacing,
                Wrap(
                  spacing: AppValues.margin12,
                  runSpacing: AppValues.margin12,
                  children: [
                    ...controller.timings.map(
                          (time) => CheckoutRadioTile(
                        title: time,
                        trailing: Radio<String>(
                          value: time,
                          activeColor: AppColors.orange,
                          groupValue: controller.selectedTime,
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectTime(value);
                            }
                          },
                        ),
                      ),
                    )..toList(),
                  ],
                ),
                defaultHeightSpacing,
                defaultHeightSpacing,
                Text(
                  AppStrings.paymentMethods,
                  style: AppTextStyles.text1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                defaultHeightSpacing,
                ...controller.paymentMethods.map(
                      (paymentMethod) => CheckoutRadioTile(
                    title: paymentMethod,
                    isAddress: true,
                    leadingIcon: AppImages.masterCard,
                    trailing: Radio<String>(
                      value: paymentMethod,
                      activeColor: AppColors.orange,
                      groupValue: controller.selectedPaymentMethod,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectAddress(value);
                        }
                      },
                    ),
                  ),
                )..toList(),
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
                  onPressed: controller.onMakePayment,
                  title: Text(
                    AppStrings.makePayment,
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
}
