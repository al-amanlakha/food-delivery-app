import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/global_utils.dart';


class SortBottomSheet extends StatefulWidget {
  final String currentSort;
  final Function(String) onSelect;

  const SortBottomSheet({
    super.key,
    required this.currentSort,
    required this.onSelect,
  });

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late String selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    List<String> sorts = [
      'Relevance',
      'Popularity',
      'Price: High to Low',
      'Price: Low to High'
    ];

    return Container(
      padding: AppPaddings.defaultPaddingAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
              child: Text(
            'Sort by',
            style: AppTextStyles.title,
          ),),
          defaultHeightSpacing,
          ...sorts.map(
            (sort) {
              return ListTile(
                title: Text(
                  sort,
                  style: selectedSort == sort
                      ? AppTextStyles.text1.copyWith(
                          fontWeight: FontWeight.w600,
                        )
                      : AppTextStyles.text1,
                ),
                trailing: selectedSort == sort
                    ? const Icon(
                        Icons.check,
                        color: AppColors.blackishGrey,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedSort = sort;
                  });
                  widget.onSelect(sort);
                  Get.back(
                    result: sort,
                  ); // Closes the bottom sheet and passes the selected sort back
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
