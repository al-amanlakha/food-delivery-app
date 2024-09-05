import 'dart:convert';

UserProfileModel profileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));
String profileModelToJson(UserProfileModel data) => json.encode(data.toJson());
class UserProfileModel {
  String? userAddress;
  final String userName;
  final String? userEmail;
  String? userProfileImage;
  final String phoneNumber;
  final String dialCode;

  UserProfileModel({
    this.userEmail,
    this.userAddress,
    this.userProfileImage,
    required this.userName,
    this.dialCode = "+44",
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userAddress': userAddress,
      'userPhoneNumber': phoneNumber,
      'userProfileImage': userProfileImage,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userName: json['userName'],
      userEmail: json['userEmail'],
      userAddress: json['userAddress'],
      phoneNumber: json['phoneNumber'],
      userProfileImage: json['userProfileImage'],
    );
  }
}
