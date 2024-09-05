import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../constants/app_values.dart';
import '../../../data/model/order/order_model.dart';
import '../../order_detail/order_detail_view.dart';
import '../../order_detail/order_detail_view_model.dart';

class MyOrdersViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  List<Order> orders = [
    Order(
      id: '001',
      imageUrl: 'https://example.com/image1.jpg',
      dateOfOrder: DateTime.now().subtract(const Duration(days: 2)),
      timeOfDelivery: '4:00 PM',
      quantity: 2,
      deliveryAddress: '123 Main St, Anytown, AT 12345',
      title: 'Gourmet Burger',
      subtotal: 29.98,
      taxes: 2.40,
      deliveryFee: 3.50,
      total: 35.88,
      isDelivered: true,
    ),
    Order(
      id: '002',
      imageUrl: 'https://example.com/image2.jpg',
      dateOfOrder: DateTime.now().subtract(const Duration(days: 1)),
      timeOfDelivery: '1:00 PM',
      quantity: 1,
      deliveryAddress: '456 Side St, Othertown, OT 67890',
      title: 'Vegetarian Pizza',
      subtotal: 15.00,
      taxes: 1.20,
      deliveryFee: 2.00,
      total: 18.20,
      isDelivered: false,
    ),
    Order(
      id: '003',
      imageUrl: 'https://example.com/image3.jpg',
      dateOfOrder: DateTime.now(),
      timeOfDelivery: '6:00 PM',
      quantity: 3,
      deliveryAddress: '789 Circle Ave, Sometown, ST 10112',
      title: 'Sushi Platter',
      subtotal: 45.00,
      taxes: 3.60,
      deliveryFee: 4.00,
      total: 52.60,
      isDelivered: true,
    ),
  ];

  final List<String> tabs = <String>[
    "Upcoming Orders",
    "Past Orders",
  ];

  void onTapTabIndex(int index) {
    if (currentTabIndex == index) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      update(); // Schedule the update to happen after the current frame
    });
    currentTabIndex = index;
    tabController.animateTo(
      index,
      curve: Curves.ease,
      duration: const Duration(
        milliseconds: AppValues.defaultAnimationDuration,
      ),
    );
  }

  void proceedWithUpcomingOrder(Order model) {
    Get.to(
          () => const OrderDetailView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
      const Duration(milliseconds: AppValues.defaultAnimationDuration),
      arguments: model,
      binding: BindingsBuilder(
            () => Get.lazyPut(
              () => OrderDetailViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  void proceedWithPastOrder(Order model) {
    Get.to(
          () => const OrderDetailView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
      const Duration(milliseconds: AppValues.defaultAnimationDuration),
      arguments: model,
      binding: BindingsBuilder(
            () => Get.lazyPut(
              () => OrderDetailViewModel(),
          fenix: true,
        ),
      ),
    );
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
