import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_values.dart';
import '../../../utils/global_utils.dart';
import '../../../widgets/buttons/generic_button.dart';
import '../../../widgets/cart/cart_tile.dart';
import 'cart_view_model.dart';

class CartView extends StatelessWidget {
  static const String id = "/CART_VIEW";

  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.white,
            title: const Text(
              AppStrings.myCart,
              style: AppTextStyles.heading2,
            ),
          ),
          body: SingleChildScrollView(
            padding: AppPaddings.defaultPaddingAll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final model = controller.cartList[index];
                    return CartTile(
                      productId: model.productId,
                      imageUrl: model.productImage,
                      productName: model.productName,
                      productQuantity: model.productQuantity,
                      increment: () => controller.incrementQuantity(model),
                      decrement: () => controller.decrementQuantity(model),
                      onClose: () => controller.removeItem(
                        model.productId,
                      ),
                      subTotal:
                          controller.updateSubTotal(model).toStringAsFixed(2),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: AppValues.margin12,
                    );
                  },
                  itemCount: controller.cartList.length,
                ),
                defaultHeightSpacing,
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.subTotal,
                  title: controller.getGrandSubtotal().toStringAsFixed(2),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.taxes,
                  title: controller.getGrandTaxes().toStringAsFixed(2),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.deliveryFee,
                  title: controller.getGrandDeliveryFee().toStringAsFixed(2),
                ),
                defaultHeightSpacing,
                getOrderSummary(
                  label: AppStrings.total,
                  title: controller.getGrandTotal().toStringAsFixed(2),
                  titleStyle: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                defaultHeightSpacing,
                GenericButton(
                  onPressed: controller.onCheckout,
                  title: Text(
                    AppStrings.checkout,
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
