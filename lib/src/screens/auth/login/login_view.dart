import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/src/constants/app_images.dart';
import 'package:food_delivery/src/constants/app_paddings.dart';
import 'package:food_delivery/src/constants/app_strings.dart';
import 'package:food_delivery/src/screens/auth/login/login_view_model.dart';
import 'package:food_delivery/src/screens/auth/signup/signup_view.dart';
import 'package:food_delivery/src/utils/global_utils.dart';
import 'package:food_delivery/src/widgets/buttons/generic_button.dart';
import 'package:food_delivery/src/widgets/textfield/generic_textfield.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/validators.dart';
import '../../../widgets/buttons/leading_trailing_button.dart';

class LoginView extends StatelessWidget {
  static const String id = "/LOGIN";

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text(
              AppStrings.login,
              style: AppTextStyles.heading2,
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Text(
                AppStrings.addDetailToLogin,
                style: AppTextStyles.title,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: AppPaddings.defaultPaddingAll,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  Text(
                    AppStrings.email,
                    style: AppTextStyles.text2.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: AppValues.margin4),
                  GenericTextField(
                    controller: controller.emailController,
                    hintText: AppStrings.hintEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validator.validateEmail,
                  ),
                  defaultHeightSpacing,
                  // Password
                  Text(
                    AppStrings.password,
                    style: AppTextStyles.text2.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: AppValues.margin4),
                  GenericTextField(
                    controller: controller.passwordController,
                    hintText: AppStrings.hintPassword,
                    isObscure: !controller.isPasswordVisible,
                    validator: Validator.validatePassword,
                    suffixIcon: controller.passwordController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              controller.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          )
                        : null,
                    onChanged: (value) => controller.update(),
                  ),
                  defaultHeightSpacing,
                  GenericButton(
                    onPressed: controller.validateAndSubmit,
                    title: Text(
                      AppStrings.login,
                      style:
                          AppTextStyles.title.copyWith(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: AppValues.margin8,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.forgotPassword,
                        style: AppTextStyles.text1,
                      ),
                    ),
                  ),
                  defaultHeightSpacing,
                  defaultHeightSpacing,
                  const Center(
                    child: Text(
                      AppStrings.orLoginWith,
                      style: AppTextStyles.text1,
                    ),
                  ),
                  defaultHeightSpacing,
                  LeadingTrailingButton(
                    onPressed: () {},
                    leading: SvgPicture.asset(
                      AppImages.google,
                      fit: BoxFit.contain,
                    ),
                    color: const Color(0xFFDD4B39),
                    title: Text(
                      AppStrings.googleLogin,
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  defaultHeightSpacing,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppStrings.doNotHaveAccount,
                        style: AppTextStyles.text1,
                        children: [
                          const WidgetSpan(
                            child: SizedBox(
                              width: AppValues.margin4,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(
                                  SignupView.id,
                                );
                              },
                            text: AppStrings.signup,
                            style: AppTextStyles.text1.copyWith(
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
