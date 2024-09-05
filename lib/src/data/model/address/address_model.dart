import 'dart:convert';
import 'package:geocoding/geocoding.dart';

// Function to decode JSON string to AddressModel
AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

// Function to encode AddressModel to JSON string
String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? county;
  String? country;
  String? postalCode;
  String? completeAddress;

  // Normal constructor with automatic complete address generation
  AddressModel({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.county,
    this.country,
    this.postalCode,
    String? completeAddress,
  }) {
    // Generate complete address if not provided
    this.completeAddress = completeAddress ?? generateCompleteAddress();
  }

  // Generates a complete address from components
  String generateCompleteAddress() {
    return [
      addressLine1,
      addressLine2,
      city,
      county,
      country,
      postalCode,
    ].where((element) => element != null && element.isNotEmpty).join(", ");
  }

  // Factory to create AddressModel from Placemark
  factory AddressModel.fromPlacemark(Placemark placemark) {
    return AddressModel(
        addressLine1: placemark.subThoroughfare,
        addressLine2: placemark.thoroughfare,
        city: placemark.locality,
        county: placemark.subAdministrativeArea,
        country: placemark.country,
        postalCode: placemark.postalCode,
        // Explicitly generates the complete address from components
        completeAddress: [
          placemark.subThoroughfare,
          placemark.thoroughfare,
          placemark.locality,
          placemark.subAdministrativeArea,
          placemark.country,
          placemark.postalCode,
        ].where((element) => element != null && element.isNotEmpty).join(", ")
    );
  }

  // Converts address data to JSON
  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'county': county,
      'country': country,
      'postalCode': postalCode,
      'completeAddress': completeAddress,
    };
  }

  // Factory to create AddressModel from JSON map
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      county: json['county'],
      country: json['country'],
      postalCode: json['postalCode'],
      completeAddress: json['completeAddress'],
    );
  }
}
