import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/validators.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/loader/generic_loader.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import '../../../widgets/textfield/generic_textfield.dart';
import 'my_profile_view_model.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProfileViewModel>(
      builder: (controller) {
        if (controller.userModel == null) {
          return const Scaffold(
            appBar: SubProfileAppBar(title: AppStrings.myProfile),
            body: Center(child: GenericLoader()),
          );
        }
        return AbsorbPointer(
          absorbing: controller.isSaving,
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              controller.onBackTap();
            },
            child: Scaffold(
              appBar: SubProfileAppBar(
                onTap: controller.onBackTap,
                title: AppStrings.myProfile,
              ),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    padding: AppPaddings.defaultPaddingAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: InkWell(
                            onTap: controller.proceedProfileOnTap,
                            child: buildProfilePicture(controller),
                          ),
                        ),
                        const SizedBox(height: AppValues.defaultPadding),
                        buildTextFieldSection(
                          controller: controller.mobileController,
                          label: AppStrings.mobileNumber,
                          hint: AppStrings.hint10Digit,
                          textInputType: TextInputType.number,
                          isMobile: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: Validator.validatePhoneNumber,
                        ),
                        buildTextFieldSection(
                          controller: controller.nameController,
                          label: AppStrings.name,
                          hint: AppStrings.hintName,
                          textInputType: TextInputType.name,
                          validator: Validator.validateName,
                        ),
                        buildTextFieldSection(
                          controller: controller.emailController,
                          label: AppStrings.email,
                          hint: AppStrings.hintEmail,
                          textInputType: TextInputType.emailAddress,
                          validator: Validator.validateEmail,
                          textInputAction: TextInputAction.done,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.defaultPadding,
                            vertical: AppValues.padding10,
                          ),
                          child: GenericButton(
                            onPressed: controller.isDataChanged
                                ? controller.saveProfile
                                : null,
                            title: Text(AppStrings.save,
                                style: AppTextStyles.title
                                    .copyWith(color: AppColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.isSaving) const GenericLoader(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfilePicture(MyProfileViewModel controller) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.lightGrey,
          backgroundImage: controller.userModel?.profileImageUrl != null
              ? NetworkImage(controller.userModel!.profileImageUrl!)
              : null,
          child: controller.isUploadingImage
              ? const CircularProgressIndicator(
                  color: AppColors.orange,
                )
              : controller.userModel?.profileImageUrl == null
                  ? const Icon(Icons.person, color: AppColors.white, size: 40)
                  : null,
        ),
        Container(
          padding: const EdgeInsets.all(AppValues.padding8),
          decoration: const BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          child: const PhosphorIcon(
            PhosphorIconsRegular.camera,
            color: AppColors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldSection({
    required TextEditingController controller,
    required String label,
    required String hint,
    required TextInputType textInputType,
    TextInputAction textInputAction = TextInputAction.next,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool isMobile = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.text2.copyWith(color: AppColors.grey),
        ),
        const SizedBox(height: AppValues.margin4),
        isMobile
            ? GenericTextField(
                controller: controller,
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
                textInputAction: textInputAction,
                keyboardType: TextInputType.number,
                hintText: hint,
                inputFormatters: inputFormatters,
                validator: validator,
              )
            : GenericTextField(
                controller: controller,
                hintText: hint,
                keyboardType: textInputType,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                validator: validator,
              ),
        const SizedBox(height: AppValues.defaultPadding),
      ],
    );
  }
}
