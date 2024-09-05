import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../../widgets/buttons/generic_button.dart';
import 'welcome_view_model.dart';

class WelcomeView extends StatelessWidget {
  static const String id = "/WElCOME_VIEW";

  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeViewModel>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(
                  AppImages.monkeyFace,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: AppValues.defaultMargin * 2,
                ),
                const Text(
                  AppStrings.welcomeToMonkeyMeal,
                  style: AppTextStyles.heading2,
                ),
                defaultHeightSpacing,
                Text(
                  AppStrings.discoverTheBestFoodsFromOver,
                  style: AppTextStyles.text2.copyWith(
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                defaultHeightSpacing,
                GenericButton(
                  onPressed: controller.onLogin,
                  title: Text(
                    AppStrings.login,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                defaultHeightSpacing,
                GenericButton(
                  onPressed: controller.onSignup,
                  color: Colors.transparent,
                  isBorder: true,
                  title: const Text(
                    AppStrings.signup,
                    style: AppTextStyles.title,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
