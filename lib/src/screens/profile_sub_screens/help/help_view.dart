import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/help/faq_entry.dart';
import '../../../widgets/profile/sub_profile_app_bar.dart';
import 'help_view_model.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpViewModel>(
      builder: (controller) {
        return Scaffold(
          appBar: const SubProfileAppBar(
            title: AppStrings.help,
          ),
          body: ListView.builder(
            itemCount: controller.faqs.length,
            padding: AppPaddings.defaultPaddingAll,
            itemBuilder: (context, index) {
              return FAQEntry(faq: controller.faqs[index]);
            },
          ),
        );
      },
    );
  }
}
