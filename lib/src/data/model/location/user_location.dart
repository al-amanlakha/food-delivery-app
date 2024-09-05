
import 'dart:convert';

UserLocation userDetailFromJson(String str) =>
    UserLocation.fromJson(json.decode(str));

String userDetailToJson(UserLocation data) => json.encode(data.toJson());

class UserLocation {
  double? lat;
  double? long;

  UserLocation({
    this.lat,
    this.long,
  });

  UserLocation.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }
}
