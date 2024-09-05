import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/src/extensions/media_query_values.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_values.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  static const String id = "/SPLASH_VIEW";

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashViewModel>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: context.screenHeight,
            alignment: Alignment.center,
            width: context.screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.splashBackground,
                ),
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  maxLines: 2,
                  text: const TextSpan(
                    text: AppStrings.monkey,
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      color: AppColors.orange,
                    ),
                    children: [
                      WidgetSpan(child: SizedBox(width: AppValues.margin4,),),
                      TextSpan(
                        text: AppStrings.meal,
                        style: TextStyle(
                            fontSize: 34,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A4B4D),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppValues.defaultMargin,
                ),
                const Text(
                  AppStrings.foodDelivery,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A4B4D),
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
