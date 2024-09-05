import 'package:get/get.dart';

class NotificationSettingsViewModel extends GetxController {
  bool notificationsEnabled = false;
  bool promotionalEmailsEnabled = false;

  void updateNotifications(bool isEnabled) {
    notificationsEnabled = isEnabled;
    update(); // Notify listeners about the change
  }

  void updatePromotionalEmails(bool isEnabled) {
    promotionalEmailsEnabled = isEnabled;
    update(); // Notify listeners about the change
  }
}
