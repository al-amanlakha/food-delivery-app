import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/src/screens/auth/login/login_view.dart';
import 'package:food_delivery/src/screens/auth/signup/signup_view_model.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import '../../../utils/validators.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/loader/generic_loader.dart';
import '../../../widgets/textfield/generic_textfield.dart';

class SignupView extends StatelessWidget {
  static const String id = "/SIGNUP";

  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupViewModel>(
      builder: (controller) {
        return AbsorbPointer(
          absorbing: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text(
                AppStrings.signup,
                style: AppTextStyles.heading2,
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Text(
                  AppStrings.addDetailToSignup,
                  style: AppTextStyles.title,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  padding: AppPaddings.defaultPaddingAll,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          AppStrings.name,
                          style: AppTextStyles.text2.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: AppValues.margin4),
                        GenericTextField(
                          controller: controller.nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          hintText: AppStrings.hintName,
                          inputFormatters: [LengthLimitingTextInputFormatter(35)],
                          validator: Validator.validateName,
                        ),
                        defaultHeightSpacing,

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
                          textInputAction: TextInputAction.next,
                          validator: Validator.validateEmail,
                        ),
                        defaultHeightSpacing,

                        // Phone Number
                        Text(
                          AppStrings.mobileNumber,
                          style: AppTextStyles.text2.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: AppValues.margin4),
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          hintText: AppStrings.hint10Digit,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: Validator.validatePhoneNumber,
                        ),
                        defaultHeightSpacing,
                        Text(
                          AppStrings.address,
                          style: AppTextStyles.text2.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: AppValues.margin4),
                        GenericTextField(
                          readOnly: true,
                          minLines: 1,
                          maxLines: 3,
                          hintText: AppStrings.hintAddress,
                          onTap: controller.onAddressTap,
                          validator: Validator.validateAddress,
                          textInputAction: TextInputAction.done,
                          controller: controller.addressController,
                          keyboardType: TextInputType.streetAddress,
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
                          textInputAction: TextInputAction.next,
                          validator: Validator.validatePassword,
                          suffixIcon: controller
                                  .passwordController.text.isNotEmpty
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

                        // Confirm Password
                        Text(
                          AppStrings.confirmPassword,
                          style: AppTextStyles.text2.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: AppValues.margin4),
                        GenericTextField(
                          controller: controller.confirmPassword,
                          hintText: AppStrings.hintPassword,
                          isObscure: !controller.isConfirmPasswordVisible,
                          validator: controller.validateConfirmPassword,
                          textInputAction: TextInputAction.done,
                          suffixIcon: controller.confirmPassword.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    controller.isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed:
                                      controller.toggleConfirmPasswordVisibility,
                                )
                              : null,
                          onChanged: (value) => controller.update(),
                        ),
                        defaultHeightSpacing,

                        // Signup Button
                        GenericButton(
                          onPressed: controller.validateAndSubmit,
                          title: Text(
                            AppStrings.signup,
                            style: AppTextStyles.title
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        defaultHeightSpacing,

                        // Login Redirect
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.alreadyHaveAccount,
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
                                      Get.offNamed(LoginView.id);
                                    },
                                  text: AppStrings.login,
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
