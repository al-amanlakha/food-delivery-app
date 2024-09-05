import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../screens/dashboard/dashboard_view.dart';
import '../../screens/dashboard/dashboard_view_model.dart';
import '../../utils/global_utils.dart';

import '../buttons/generic_button.dart';

class OrderConfirmedDialog extends StatelessWidget {
  final String orderId;

  const OrderConfirmedDialog({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(AppValues.defaultPadding * 2),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImages.paymentDone,
            fit: BoxFit.contain,
          ),
          defaultHeightSpacing,
          Text(
            AppStrings.yourOrderIsConfirmed,
            style: AppTextStyles.text1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: AppValues.margin12,
          ),
          const Text(
            AppStrings.trackYourOrder,
            style: AppTextStyles.text2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppValues.margin12,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Order id: ",
              style: AppTextStyles.text1.copyWith(
                color: AppColors.grey,
              ),
              children: [
                const TextSpan(text: ''),
                TextSpan(
                  text: orderId,
                  style: AppTextStyles.text1.copyWith(
                    color: AppColors.blackishGrey,
                  ),
                ),
              ],
            ),
          ),
          defaultHeightSpacing,
          GenericButton(
            onPressed: () {},
            title: Text(
              AppStrings.trackMyOrder,
              style: AppTextStyles.title.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          defaultHeightSpacing,
          TextButton(
            onPressed: () {
              Get.find<DashboardViewModel>().onBottomNavTap(4);
              Get.until((route) => route.settings.name == DashboardView.id,);
              Get.back();
            },
            child: Text(
              AppStrings.backToHome,
              style: AppTextStyles.title.copyWith(color: AppColors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
