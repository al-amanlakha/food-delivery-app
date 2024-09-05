import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.verifyWithOtpSentTo} ${controller.phoneModel.dialCode} ${controller.phoneModel.phoneNumber}",
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
                        color: AppColors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  errorPinTheme: PinTheme(
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
                        color: AppColors.warningRed,
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
                        color: AppColors.blackishGrey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                defaultHeightSpacing,
                defaultHeightSpacing,
                GenericButton(
                  onPressed:
                      controller.otpCode.isEmpty ? null : controller.onContinue,
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
                                  "${AppStrings.retryIn} ${controller.seconds} ")
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
        );
      },
    );
  }
}
