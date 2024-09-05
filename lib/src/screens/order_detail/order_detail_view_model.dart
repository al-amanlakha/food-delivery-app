import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/order/order_model.dart';
import '../../widgets/dialogs/order_confirmed_dialog.dart';

class OrderDetailViewModel extends GetxController {
  late final Order model;
  final uuid = const Uuid();

  @override
  void onInit() {
    _loadArguments();
    super.onInit();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      model = Get.arguments;
    }
  }

  void onReorder() {
    Get.dialog(
      OrderConfirmedDialog(
        orderId: uuid.v1(),
      ),
    );
  }

  void onTrackOrder() {}
}
