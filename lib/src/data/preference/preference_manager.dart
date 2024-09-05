
import '../model/address/address_model.dart';
import '../model/location/user_location.dart';
import '../model/profile/user_profile_model.dart';

abstract class PreferenceManager {
  static const keyToken = "token";

  Future<String> getString(String key, {String defaultValue = ""});

  Future<bool> setString(String key, String value);

  Future<int> getInt(String key, {int defaultValue = 0});

  Future<bool> setInt(String key, int value);

  Future<double> getDouble(String key, {double defaultValue = 0.0});

  Future<bool> setDouble(String key, double value);

  Future<bool> getBool(String key, {bool defaultValue = false});

  Future<bool> setBool(String key, bool value);

  Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []});

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> remove(String key);

  Future<bool> clear();

  Future<void> setRememberMe({required Map<String, dynamic> map});

  Future<Map<String, dynamic>?> getRememberMe();

  Future<void> setAccessToken({required String accessToken});

  Future<String> getAccessToken();

  Future<void> setUserLocation({required UserLocation userLocation});

  Future<UserLocation?> getUserLocation();

  Future<void> setUserProfile(UserProfileModel userProfile);

  Future<UserProfileModel?> getUserProfile();

  Future<void> setUserAddress(AddressModel userAddress);

  Future<AddressModel?> getUserAddress();
}
