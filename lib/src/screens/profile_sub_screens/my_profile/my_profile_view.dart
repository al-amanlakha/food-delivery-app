import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../constants/app_colors.dart';


import '../../../constants/app_images.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../data/model/profile/user_profile_model.dart';
import '../../../utils/global_utils.dart';
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
        if (controller.model == null) {
          return const Scaffold(
            appBar: SubProfileAppBar(
              title: AppStrings.myProfile,
            ),
            body: Center(
              child: GenericLoader(),
            ),
          );
        } else {
          final UserProfileModel model = controller.model!;
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if(didPop) {
                return;
              }
              controller.onBackTap();
            },
            child: Scaffold(
              appBar: SubProfileAppBar(
                onTap: controller.onBackTap,
                title: AppStrings.myProfile,
              ),
              body: SingleChildScrollView(
                padding: AppPaddings.defaultPaddingAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: controller.proceedProfileOnTap,
                        child: IntrinsicWidth(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.lightGrey,
                                backgroundImage: model.userProfileImage != null
                                    ? (model.userProfileImage!.startsWith('http')
                                        ? NetworkImage(model.userProfileImage!)
                                        : FileImage(
                                            File(model.userProfileImage!)))
                                    : null,
                                child: model.userProfileImage == null
                                    ? const Icon(
                                        Icons.person,
                                        color: AppColors.white,
                                        size: 36,
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 15,
                                child: Container(
                                  padding: const EdgeInsets.all(AppValues.padding4,),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.orange,
                                    ),
                                    child: const PhosphorIcon(PhosphorIconsRegular.camera, color: AppColors.white,)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    defaultHeightSpacing,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                        // Limits the input to 10 digits
                      ],
                    ),
                    defaultHeightSpacing,
                    Text(
                      AppStrings.name,
                      style: AppTextStyles.text2.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.margin4,
                    ),
                    GenericTextField(
                      controller: controller.nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      hintText: AppStrings.hintName,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(35),
                        // Limits the input to 10 digits
                      ],
                    ),
                    defaultHeightSpacing,
                    Text(
                      "${AppStrings.email} ${AppStrings.optional}",
                      style: AppTextStyles.text2.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.margin4,
                    ),
                    GenericTextField(
                      controller: controller.emailController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppStrings.hintEmail,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.defaultPadding,
                  vertical: AppValues.padding10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GenericButton(
                      onPressed: controller.isDataChanged
                          ? controller.saveProfile
                          : null,
                      title: Text(
                        AppStrings.save,
                        style:
                            AppTextStyles.title.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
