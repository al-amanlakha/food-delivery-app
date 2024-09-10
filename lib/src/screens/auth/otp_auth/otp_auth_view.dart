import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/src/widgets/loader/generic_loader.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/buttons/generic_button.dart';
import 'otp_auth_view_model.dart';

class OtpAuthView extends StatelessWidget {
  static const String id = "/OTP_AUTH_VIEW";

  const OtpAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpAuthViewModel>(
      builder: (controller) {
        return AbsorbPointer(
          absorbing: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: AppPaddings.defaultPaddingAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppStrings.verifyWithOtpSentTo} ${controller.phoneModel.dialCode}${controller.phoneModel.phoneNumber}",
                        style: AppTextStyles.heading1,
                      ),
                      defaultHeightSpacing,
                      defaultHeightSpacing,
                      Pinput(
                        length: 6,
                        autofocus: true,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.send,
                        animationCurve: Curves.ease,
                        onCompleted: controller.onCompleted,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // Highlight error state when OTP is incorrect
                        defaultPinTheme: PinTheme(
                          constraints: const BoxConstraints(
                            minWidth: 58,
                            maxWidth: 58,
                            minHeight: 51,
                            maxHeight: 51,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppValues.radius12,
                            ),
                            border: Border.all(
                              color: controller.isError
                                  ? AppColors.warningRed
                                  : AppColors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          constraints: const BoxConstraints(
                            minWidth: 58,
                            maxWidth: 58,
                            minHeight: 51,
                            maxHeight: 51,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppValues.radius12,
                            ),
                            border: Border.all(
                              color: controller.isError
                                  ? AppColors.warningRed
                                  : AppColors.blackishGrey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      defaultHeightSpacing,
                      defaultHeightSpacing,
                      GenericButton(
                        onPressed: controller.otpCode.isEmpty
                            ? null
                            : controller.onContinue,
                        title: Text(
                          AppStrings.continueButton,
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      defaultHeightSpacing,
                      RichText(
                        text: TextSpan(
                          text: AppStrings.didNotGetOtp,
                          style: AppTextStyles.text3.copyWith(
                            color: AppColors.grey,
                          ),
                          children: [
                            controller.seconds > 0
                                ? TextSpan(
                                    text:
                                        "${AppStrings.retryIn} ${controller.seconds} ",
                                    style: AppTextStyles.text3.copyWith(
                                      color: AppColors.grey,
                                    ),
                                  )
                                : TextSpan(
                                    text: AppStrings.retry,
                                    style: AppTextStyles.text3.copyWith(
                                      color: AppColors.warningRed,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.startTimer(time: 60);
                                      },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                controller.isLoading
                    ? const GenericLoader()
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
