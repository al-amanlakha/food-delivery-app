import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  static const String id = "/PROFILE_VIEW";

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      builder: (controller) {
        final model = controller.userProfileModel;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppPaddings.defaultPaddingAll,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  defaultHeightSpacing,
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.lightGrey,
                      backgroundImage: model.userProfileImage != null
                          ? (model.userProfileImage!.startsWith('http')
                              ? NetworkImage(model.userProfileImage!)
                              : FileImage(File(model.userProfileImage!)))
                          : null,
                      child: model.userProfileImage == null
                          ? const Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 36,
                            )
                          : null,
                    ),
                  ),
                  defaultHeightSpacing,
                  Center(
                    child: Text(
                      model.userName,
                      style: AppTextStyles.heading3,
                    ),
                  ),
                  const SizedBox(
                    height: AppValues.margin4,
                  ),
                  Center(
                    child: Text(
                      "+44 ${model.phoneNumber}",
                      style: AppTextStyles.text1,
                    ),
                  ),
                  defaultHeightSpacing,
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.person,
                    title: AppStrings.myProfile,
                    onTap: controller.onMyProfileTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.mapPin,
                    title: AppStrings.addressBook,
                    onTap: controller.onAddressBookTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.creditCard,
                    title: AppStrings.paymentMethods,
                    onTap: controller.onPaymentMethodsTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.notepad,
                    title: AppStrings.myOrders,
                    onTap: controller.onMyOrdersTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.userGear,
                    title: AppStrings.preferences,
                    onTap: controller.onPreferencesTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.gear,
                    title: AppStrings.notificationSettings,
                    onTap: controller.onNotificationSettingsTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.question,
                    title: AppStrings.help,
                    onTap: controller.onHelpAndFAQTap,
                  ),
                  const Divider(
                    color: AppColors.lightGrey,
                    indent: 40,
                  ),
                  onTapOptionTiles(
                    leadingIcon: PhosphorIconsRegular.signOut,
                    title: AppStrings.logout,
                    onTap: controller.onLogoutTap,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget onTapOptionTiles({
    required PhosphorFlatIconData leadingIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      onTap: onTap,
      leading: PhosphorIcon(
        leadingIcon,
        color: AppColors.orange,
      ),
      title: Text(
        title,
        style: AppTextStyles.text1.copyWith(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: SvgPicture.asset(
        AppImages.chevron,
        fit: BoxFit.contain,
      ),
    );
  }
}
