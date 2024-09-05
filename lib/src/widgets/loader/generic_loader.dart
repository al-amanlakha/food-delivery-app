import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';

class GenericLoader extends StatelessWidget {
  const GenericLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColors.blackishGrey.withOpacity(0.4),
        padding: AppPaddings.defaultPaddingAll,
        child: const CircularProgressIndicator(
          backgroundColor: AppColors.white,
          color: AppColors.orange,
        ),
      ),
    );
  }
}
