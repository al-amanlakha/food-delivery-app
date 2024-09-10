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
import '../../../data/model/profile/user_model.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/loader/generic_loader.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  static const String id = "/PROFILE_VIEW";

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      builder: (controller) {
        final model = controller.userModel;
        return AbsorbPointer(
          absorbing: controller.isLoading,
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  buildProfileContent(context, model, controller),
                  controller.isLoading ? const GenericLoader() : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileContent(BuildContext context, UserModel? model, ProfileViewModel controller) {
    return SingleChildScrollView(
      padding: AppPaddings.defaultPaddingAll,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          defaultHeightSpacing,
          buildProfileAvatar(model),
          defaultHeightSpacing,
          buildProfileName(model),
          const SizedBox(
            height: AppValues.margin4,
          ),
          buildPhoneNumber(model),
          defaultHeightSpacing,
          buildProfileOptions(controller),
        ],
      ),
    );
  }

  Widget buildProfileAvatar(UserModel? model) {
    return Center(
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppColors.lightGrey,
        backgroundImage: model != null && model.profileImageUrl != null
            ? (model.profileImageUrl!.startsWith('http')
            ? NetworkImage(model.profileImageUrl!)
            : FileImage(File(model.profileImageUrl!)))
            : null,
        child: model != null && model.profileImageUrl == null
            ? const Icon(
          Icons.person,
          color: AppColors.white,
          size: 36,
        )
            : null,
      ),
    );
  }

  Widget buildProfileName(UserModel? model) {
    return Center(
      child: Text(
        model?.fullName ?? "Username",
        style: AppTextStyles.heading3,
      ),
    );
  }

  Widget buildPhoneNumber(UserModel? model) {
    return Center(
      child: Text(
        "${model?.dialCode} ${model?.phoneNumber ?? '0000000000'}",
        style: AppTextStyles.text1,
      ),
    );
  }

  Widget buildProfileOptions(ProfileViewModel controller) {
    return Column(
      children: [
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.person,
          title: AppStrings.myProfile,
          onTap: controller.onMyProfileTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.mapPin,
          title: AppStrings.addressBook,
          onTap: controller.onAddressBookTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.creditCard,
          title: AppStrings.paymentMethods,
          onTap: controller.onPaymentMethodsTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.notepad,
          title: AppStrings.myOrders,
          onTap: controller.onMyOrdersTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.userGear,
          title: AppStrings.preferences,
          onTap: controller.onPreferencesTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.gear,
          title: AppStrings.notificationSettings,
          onTap: controller.onNotificationSettingsTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.question,
          title: AppStrings.help,
          onTap: controller.onHelpAndFAQTap,
        ),
        const Divider(
          color: AppColors.lightGrey,
          indent: 40,
        ),
        onTapOptionTile(
          leadingIcon: PhosphorIconsRegular.signOut,
          title: AppStrings.logout,
          onTap: controller.onLogoutTap,
        ),
      ],
    );
  }

  Widget onTapOptionTile({
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