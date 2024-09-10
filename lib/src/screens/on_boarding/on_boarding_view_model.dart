import 'package:flutter/cupertino.dart';
import 'package:food_delivery/src/constants/app_images.dart';
import 'package:food_delivery/src/constants/app_values.dart';
import 'package:food_delivery/src/data/model/on_boarding/on_boarding_model.dart';
import 'package:food_delivery/src/screens/dashboard/dashboard_view.dart';
import 'package:get/get.dart';

import '../../constants/app_strings.dart';
import '../../data/preference/preference_manager.dart';

class OnBoardingViewModel extends GetxController {
  final PreferenceManager _preference =
  Get.find(tag: (PreferenceManager).toString());
  final PageController pageController = PageController(initialPage: 0);
  int pageNo = 0;

  List<OnBoardingModel> modelList = [
    OnBoardingModel(
      screenNo: 0,
      text: AppStrings.screenOneOnBoarding,
      description: AppStrings.screenOneOnBoardingDescription,
      image: AppImages.foodLoveImage,
    ),
    OnBoardingModel(
      screenNo: 1,
      text: AppStrings.screenTwoOnBoarding,
      description: AppStrings.screenTwoOnBoardingDescription,
      image: AppImages.deliveryImage,
    ),
    OnBoardingModel(
      screenNo: 2,
      text: AppStrings.screenThirdOnBoarding,
      description: AppStrings.screenThirdOnBoardingDescription,
      image: AppImages.liveTrackingImage,
    )
  ];

  updatePageNo(int index) {
    pageNo = index;
    update();
  }

  void goToOtherPage() async {
    if (pageNo == 0) {
      pageController.animateToPage(
        1,
        duration:
            const Duration(milliseconds: AppValues.defaultAnimationDuration),
        curve: Curves.ease,
      );
    } else if (pageNo == 1) {
      pageController.animateToPage(
        2,
        duration: const Duration(
          milliseconds: AppValues.defaultAnimationDuration,
        ),
        curve: Curves.ease,
      );
    } else {
      await _preference.setOnboardingShown(true);
      Get.offAllNamed(
        DashboardView.id,
      );
    }
  }
}
