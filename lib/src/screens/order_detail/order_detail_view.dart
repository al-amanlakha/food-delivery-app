import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/global_utils.dart';
import '../../widgets/buttons/generic_button.dart';
import '../../widgets/my_orders/my_order_detail_card.dart';
import '../../widgets/profile/sub_profile_app_bar.dart';
import 'order_detail_view_model.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailViewModel>(
      builder: (controller) {
        final model = controller.model;
        return Scaffold(
          appBar: const SubProfileAppBar(title: AppStrings.orderDetails),
          body: SingleChildScrollView(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Order id: ",
                    style: AppTextStyles.text1.copyWith(
                      color: AppColors.grey,
                    ),
                    children: [
                      const TextSpan(text: ''),
                      TextSpan(
                        text: model.id,
                        style: AppTextStyles.text1.copyWith(
                          color: AppColors.blackishGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                defaultHeightSpacing,
                RichText(
                  text: TextSpan(
                    text: "Order date: ",
                    style: AppTextStyles.text1.copyWith(
                      color: AppColors.grey,
                    ),
                    children: [
                      const TextSpan(text: ''),
                      TextSpan(
                        text: model.formattedDate,
                        style: AppTextStyles.text1.copyWith(
                          color: AppColors.blackishGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                defaultHeightSpacing,
                MyOrderDetailCard(model: model),
                defaultHeightSpacing,
                RichText(
                  text: TextSpan(
                    text:
                        model.isDelivered ? "Delivered" : "To be delivered at",
                    style: AppTextStyles.text1.copyWith(
                      color: AppColors.grey,
                    ),
                    children: [
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: model.timeOfDelivery,
                        style: AppTextStyles.text1.copyWith(
                          color: AppColors.blackishGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                defaultHeightSpacing,
                defaultHeightSpacing,
                Text(
                  AppStrings.deliveryAddress,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                defaultHeightSpacing,
                Text(
                  model.deliveryAddress,
                  style: AppTextStyles.text1.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                defaultHeightSpacing,
                defaultHeightSpacing,
                Text(
                  AppStrings.orderSummary,
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.subTotal,
                  title: model.subtotal.toString(),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.taxes,
                  title: model.taxes.toString(),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.deliveryFee,
                  title: model.deliveryFee.toString(),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.total,
                  title: model.total.toString(),
                  titleStyle: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.defaultPadding,
              vertical: AppValues.padding10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GenericButton(
                  onPressed: model.isDelivered
                      ? controller.onReorder
                      : controller.onTrackOrder,
                  title: Text(
                    model.isDelivered
                        ? AppStrings.reorder
                        : AppStrings.trackOrder,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getOrderSummary({
    required String label,
    required String title,
    TextStyle? titleStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: titleStyle ?? AppTextStyles.text2,
        ),
        Text(
          "£ $title",
          style: titleStyle ?? AppTextStyles.text2,
        ),
      ],
    );
  }
}
