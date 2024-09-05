import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_values.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final Color color;
  final double? elevation;
  final double height;
  final double? minWidth;
  final bool isBorder;

  const GenericButton({
    super.key,
    this.onPressed,
    this.leading,
    this.trailing,
    this.color = AppColors.orange,
    required this.title,
    this.elevation = 0,
    this.height = 56,
    this.isBorder = false,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: minWidth,
      disabledColor: AppColors.orange.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppValues.defaultRadius,
        ),
        side: isBorder
            ? const BorderSide(
                color: AppColors.orange,
                width: 1,
              )
            : BorderSide.none,
      ),
      elevation: elevation,
      height: height,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (leading != null) ...[
                  leading!,
                ],
              ],
            ),
          ),
          Center(
            child: title,
          ),
        ],
      ),
    );
  }
}
