import 'dart:convert';

import 'package:food_delivery/src/data/model/profile/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/address/address_model.dart';
import '../model/location/user_location.dart';
import 'preference_manager.dart';

class PreferenceManagerImpl implements PreferenceManager {
  final _preference = SharedPreferences.getInstance();

  @override
  Future<String> getString(String key, {String defaultValue = ""}) {
    return _preference
        .then((preference) => preference.getString(key) ?? defaultValue);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _preference.then((preference) => preference.setString(key, value));
  }

  @override
  Future<int> getInt(String key, {int defaultValue = 0}) {
    return _preference
        .then((preference) => preference.getInt(key) ?? defaultValue);
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _preference.then((preference) => preference.setInt(key, value));
  }

  @override
  Future<double> getDouble(String key, {double defaultValue = 0.0}) {
    return _preference
        .then((preference) => preference.getDouble(key) ?? defaultValue);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _preference.then((preference) => preference.setDouble(key, value));
  }

  @override
  Future<bool> getBool(String key, {bool defaultValue = false}) {
    return _preference
        .then((preference) => preference.getBool(key) ?? defaultValue);
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return _preference.then((preference) => preference.setBool(key, value));
  }

  @override
  Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _preference
        .then((preference) => preference.getStringList(key) ?? defaultValue);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _preference
        .then((preference) => preference.setStringList(key, value));
  }

  @override
  Future<bool> remove(String key) {
    return _preference.then((preference) => preference.remove(key));
  }

  @override
  Future<bool> clear() {
    return _preference.then((preference) => preference.clear());
  }

  @override
  Future<void> setRememberMe({required Map<String, dynamic> map}) async {
    _preference.then(
      (preference) => preference.setString(
        'rememberMe',
        json.encode(map),
      ),
    );
  }

  @override
  Future<Map<String, dynamic>?> getRememberMe() async {
    var result = await _preference.then(
      (preference) => preference.getString('rememberMe'),
    );
    if (result != null) {
      return json.decode(result);
    }
    return null;
  }

  @override
  Future<void> setAccessToken({required String accessToken}) async {
    return _preference.then(
      (preferences) => preferences.setString(
        'token',
        accessToken,
      ),
    );
  }

  @override
  Future<String> getAccessToken() async {
    final SharedPreferences prefs =
        await _preference; // Wait until the SharedPreferences instance is ready
    return prefs.getString('token') ?? ''; // Return the value directly
  }

  @override
  Future<void> setUserLocation({required UserLocation userLocation}) {
    return _preference.then(
      (preference) => preference.setString(
        "userLocation",
        userDetailToJson(userLocation),
      ),
    );
  }

  @override
  Future<UserLocation?> getUserLocation() {
    return _preference.then((pref) {
      String? userLoc;
      userLoc = pref.getString("userLocation");
      if (userLoc == null) {
        return null;
      } else {
        return userDetailFromJson(userLoc);
      }
    });
  }

  @override
  Future<void> setUserProfile(UserModel userProfile) async {
    String userProfileJson = profileModelToJson(userProfile);
    await _preference
        .then((prefs) => prefs.setString("userProfile", userProfileJson));
  }

  @override
  Future<UserModel?> getUserProfile() async {
    final SharedPreferences prefs = await _preference;
    String? userProfileString = prefs.getString("userProfile");
    if (userProfileString == null) return null;
    return profileModelFromJson(userProfileString);
  }
@override
  Future<void> setUserAddress(AddressModel userAddress) async {
    String userAddressJson = addressModelToJson(userAddress);
    await _preference
        .then((prefs) => prefs.setString("userAddress", userAddressJson));
  }

  @override
  Future<AddressModel?> getUserAddress() async {
    final SharedPreferences prefs = await _preference;
    String? userAddressString = prefs.getString("userAddress");
    if (userAddressString == null) return null;
    return addressModelFromJson(userAddressString);
  }

  @override
  Future<bool> setOnboardingShown(bool shown) {
    return _preference.then((prefs) => prefs.setBool('onboardingShown', shown));
  }

  @override
  Future<bool> isOnboardingShown() {
    return _preference.then((prefs) => prefs.getBool('onboardingShown') ?? false);
  }
}
