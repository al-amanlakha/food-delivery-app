import 'dart:convert';

import 'package:food_delivery/src/constants/app_strings.dart';

import '../address/address_model.dart';

UserModel profileModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String profileModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String firstName;
  String lastName;
  String fullName;
  String email;
  bool emailVerified;
  String? phoneNumber;
  String dialCode;
  bool phoneVerified;
  String? profileImageUrl;
  DateTime dateJoined;
  String? verificationId;
  List<AddressModel>? addresses;

  UserModel({
    required this.id,
    required this.fullName,
    this.firstName = '',
    this.lastName = '',
    required this.email,
    this.emailVerified = false,
    this.phoneNumber,
    this.dialCode = AppStrings.ukDialCode,
    this.phoneVerified = false,
    this.profileImageUrl,
    required this.dateJoined,
    this.addresses,
    this.verificationId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        fullName: json['fullName'],
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'],
        emailVerified: json['emailVerified'] ?? false,
        phoneNumber: json['phoneNumber'],
        dialCode: json['dialCode'],
        phoneVerified: json['phoneVerified'] ?? false,
        profileImageUrl: json['profileImageUrl'],
        dateJoined: DateTime.parse(json['dateJoined']),
        addresses: json['addresses'] != null
            ? List<AddressModel>.from(
                json['addresses'].map((x) => AddressModel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'emailVerified': emailVerified,
        'phoneNumber': phoneNumber,
        'dialCode': dialCode,
        'phoneVerified': phoneVerified,
        'profileImageUrl': profileImageUrl,
        'dateJoined': dateJoined.toIso8601String(),
        'addresses': addresses != null
            ? List<dynamic>.from(addresses!.map((x) => x.toJson()))
            : null,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
