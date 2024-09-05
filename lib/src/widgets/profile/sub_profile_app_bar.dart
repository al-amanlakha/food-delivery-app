import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_text_styles.dart';

class SubProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const SubProfileAppBar({
    super.key,
    required this.title,
    this.onTap,
    this.bottom, this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
        onPressed: onTap != null
            ? onTap!
            : () {
                Get.back();
              },
      ),
      title: Text(
        title,
        style: AppTextStyles.heading2,
      ),
      actions: actions,
      centerTitle: true,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    if (bottom != null) {
      return const Size.fromHeight(2 * kToolbarHeight);
    }
    else {
      return const Size.fromHeight(kToolbarHeight);
    }
  }
}
