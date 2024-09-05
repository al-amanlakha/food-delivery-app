import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../data/model/order/order_model.dart';
import '../smart_image/smart_image_provider.dart';

class MyOrderDetailCard extends StatelessWidget {
  final Order model;
  final VoidCallback? onTap;

  const MyOrderDetailCard({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppValues.radius18,
          ),
        ),
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
                        tag: model.id,
                        child: SmartImageProvider(
                          imageUrl: model.imageUrl,
                          fit: BoxFit.contain,
                          height: 100,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title,
                        style: AppTextStyles.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Qty: ",
                          style: AppTextStyles.text4.copyWith(
                            color: AppColors.grey,
                          ),
                          children: [
                            const TextSpan(text: ''),
                            TextSpan(
                              text: model.quantity.toString(),
                              style: AppTextStyles.text4.copyWith(
                                color: AppColors.blackishGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "£ ",
                          style: AppTextStyles.text4.copyWith(
                            color: AppColors.orange,
                          ),
                          children: [
                            const TextSpan(text: ''),
                            TextSpan(
                              text: '${model.subtotal}',
                              style: AppTextStyles.text4.copyWith(
                                color: AppColors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
