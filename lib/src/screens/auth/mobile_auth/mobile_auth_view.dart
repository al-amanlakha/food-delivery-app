import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/textfield/generic_textfield.dart';
import 'mobile_auth_view_model.dart';

class MobileAuthView extends StatelessWidget {
  static const String id = "/MOBILE_AUTH_VIEW";

  const MobileAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MobileAuthViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.enterYourMobile,
                  style: AppTextStyles.heading1,
                ),
                defaultHeightSpacing,
                defaultHeightSpacing,
                Text(
                  AppStrings.mobileNumber,
                  style: AppTextStyles.text2.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(
                  height: AppValues.margin4,
                ),
                GenericTextField(
                  controller: controller.mobileController,
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppStrings.ukDialCode,
                        style: AppTextStyles.text1,
                      ),
                      const SizedBox(
                        width: AppValues.margin4,
                      ),
                      Text(
                        "|",
                        style: AppTextStyles.text1.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: AppValues.margin4,
                      ),
                    ],
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  hintText: AppStrings.hint10Digit,
                  onChanged: controller.onChanged,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                    // Limits the input to 10 digits
                  ],
                ),
                defaultHeightSpacing,
                GenericButton(
                  onPressed: controller.mobileNumber.isEmpty
                      ? null
                      : controller.onGetOtp,
                  title: Text(
                    AppStrings.getOTP,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                defaultHeightSpacing,
                RichText(
                  text: TextSpan(
                    text: AppStrings.byClickingYouAccept,
                    style: AppTextStyles.text3,
                    children: [
                      TextSpan(
                        text: AppStrings.termsOfService,
                        style: AppTextStyles.text3.copyWith(
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("Terms of Service Clicked");
                          },
                      ),
                      const TextSpan(
                          text: AppStrings.and, style: AppTextStyles.text3),
                      TextSpan(
                        text: AppStrings.privacyPolicy,
                        style: AppTextStyles.text3.copyWith(
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("Privacy Policy Clicked");
                          },
                      ),
                    ],
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
