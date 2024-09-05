import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/notification/switch_with_label.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import 'notification_settings_view_model.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationSettingsViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: const SubProfileAppBar(
            title: AppStrings.notificationSettings,
          ),
          body: Column(
            children: [
              defaultHeightSpacing,
              SwitchWithLabel(
                label: AppStrings.receivePromotionalEmails,
                initialValue: controller.promotionalEmailsEnabled,
                onChanged: (value) {
                  controller.updatePromotionalEmails(value);
                },
              ),
              const Divider(
                color: AppColors.lightGrey,
              ),
            defaultHeightSpacing,
            SwitchWithLabel(
                label: AppStrings.receiveNotifications,
                initialValue: controller.notificationsEnabled,
                onChanged: (value) {
                  controller.updateNotifications(value);
                },
              ),
              const Divider(
                color: AppColors.lightGrey,
              ),
            ],
          ),
        );
      },
    );
  }
}
