import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../smart_image/smart_image_provider.dart';

class CartTile extends StatelessWidget {
  final String imageUrl;
  final String subTotal;
  final String productId;
  final String productName;
  final int productQuantity;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final VoidCallback? increment;
  final VoidCallback? decrement;

  const CartTile({
    super.key,
    this.onTap,
    this.onClose,
    this.increment,
    this.decrement,
    required this.imageUrl,
    required this.subTotal,
    required this.productId,
    required this.productName,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppValues.radius18,
                ),
              ),
              margin: EdgeInsets.zero,
              color: AppColors.white,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(
                            AppValues.radius18,
                          ),
                        ),
                        child: Container(
                          color: AppColors.gradientColor1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                              tag: productId,
                              child: SmartImageProvider(
                                imageUrl: imageUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(
                          AppValues.padding8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              productName,
                              style: AppTextStyles.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            defaultHeightSpacing,
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: decrement,
                                        child: const Icon(
                                          Icons.remove_circle_outline_outlined,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: AppValues.margin8,
                                      ),
                                      Text(
                                        productQuantity.toString(),
                                        style: AppTextStyles.text1,
                                      ),
                                      const SizedBox(
                                        width: AppValues.margin8,
                                      ),
                                      InkWell(
                                        onTap: increment,
                                        child: const Icon(
                                          Icons.add_circle_outline_outlined,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "£ $subTotal",
                                    style: AppTextStyles.text1.copyWith(
                                      color: AppColors.orange,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: InkWell(
              onTap: onClose,
              child: Container(
                padding: const EdgeInsets.all(
                  AppValues.padding4,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
