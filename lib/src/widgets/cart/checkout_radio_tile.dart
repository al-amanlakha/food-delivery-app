import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';

class CheckoutRadioTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final String? leadingIcon;
  final bool isAddress;

  const CheckoutRadioTile({
    super.key,
    required this.title,
    this.leadingIcon,
    this.isAddress = false,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:AppValues.padding10, vertical: AppValues.padding8,),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppValues.radius18,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            SvgPicture.asset(
              leadingIcon!,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: AppValues.margin8,),
          ],
          if (isAddress)
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.text2,
              ),
            ),
          if(!isAddress)
            Text(
              title,
              style: AppTextStyles.text2,
            ),
          const SizedBox(width: AppValues.margin8,),
          trailing,
        ],
      ),
    );
  }
}
