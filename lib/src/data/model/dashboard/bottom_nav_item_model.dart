import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavItemModel {
  final String title;
  final bool isActive;
  final PhosphorFlatIconData iconData;

  BottomNavItemModel({
    required this.title,
    this.isActive = false,
    required this.iconData,
  });
}
