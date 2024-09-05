import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import 'payment_methods_view_model.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodsViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: const SubProfileAppBar(
            title: AppStrings.paymentMethods,
          ),
          body: Padding(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              children: [
                ListTile(
                  onTap: controller.onCardTap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppValues.radius12,
                    ),
                    side: const BorderSide(
                      color: AppColors.blackishGrey,
                      width: 0.5,
                    )
                  ),
                  title: const Text(
                    AppStrings.masterCard,
                    style: AppTextStyles.text1,
                  ),
                  leading: SvgPicture.asset(
                    AppImages.masterCard,
                    fit: BoxFit.contain,
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
