import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_paddings.dart';
import '../../../../utils/global_utils.dart';
import '../../../../widgets/my_orders/my_order_card.dart';
import '../my_orders_view_model.dart';

class PastOrders extends StatelessWidget {
  const PastOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrdersViewModel>(
      builder: (controller) {
        final pastOrders =
            controller.orders.where((order) => order.isDelivered).toList();
        return ListView.separated(
          shrinkWrap: true,
          padding: AppPaddings.defaultPaddingAll,
          itemBuilder: (context, index) {
            return MyOrderCard(
              onTap: () => controller.proceedWithPastOrder(
                pastOrders[index],
              ),
              model: pastOrders[index],
            );
          },
          separatorBuilder: (context, index) => defaultHeightSpacing,
          itemCount: pastOrders.length,
        );
      },
    );
  }
}
