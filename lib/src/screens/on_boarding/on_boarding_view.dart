import 'package:flutter/material.dart';
import 'package:food_delivery/src/constants/app_colors.dart';
import 'package:food_delivery/src/constants/app_paddings.dart';
import 'package:food_delivery/src/constants/app_strings.dart';
import 'package:food_delivery/src/constants/app_text_styles.dart';
import 'package:food_delivery/src/screens/on_boarding/on_boarding_view_model.dart';
import 'package:food_delivery/src/utils/global_utils.dart';
import 'package:food_delivery/src/widgets/buttons/generic_button.dart';
import 'package:get/get.dart';

import '../../widgets/on_boarding/on_boarding.dart';

class OnBoardingView extends StatelessWidget {
  static const String id = "/ONBOARDING_VIEW";

  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingViewModel>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  reverse: false,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    controller.updatePageNo(index);
                  },
                  controller: controller.pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.modelList.length,
                  itemBuilder: (context, index) {
                    return OnBoarding(
                      screenNo: controller.modelList[index].screenNo,
                      text: controller.modelList[index].text,
                      description: controller.modelList[index].description,
                      image: controller.modelList[index].image,
                    );
                  },
                ),
              ),
              Padding(
                padding: AppPaddings.defaultPaddingHorizontal,
                child: GenericButton(
                  onPressed: controller.goToOtherPage,
                  title: Text(
                    AppStrings.next,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              defaultHeightSpacing,
              defaultHeightSpacing,
              defaultHeightSpacing,
            ],
          ),
        );
      },
    );
  }
}
