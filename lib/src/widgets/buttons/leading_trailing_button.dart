import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_values.dart';

class LeadingTrailingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final Color color;
  final double? elevation;
  final double height;
  final double? minWidth;
  final bool isBorder;

  const LeadingTrailingButton({
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
    return SizedBox(
      height: height,
      child: MaterialButton(
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
          fit: StackFit.expand,
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
                  if (trailing != null) ...[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: trailing,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Center(
              child: title,
            ),
          ],
        ),
      ),
    );
  }
}
