import 'package:get/get.dart';

import '../../../data/model/preferences/preference_option.dart';

class PreferencesViewModel extends GetxController{
  var preferences = Preferences.initial().obs;

  void onTapSaveMyPreference () {}

  void toggleSelection(PreferenceOption option) {
    option.isSelected.value = !option.isSelected.value;
  }
}