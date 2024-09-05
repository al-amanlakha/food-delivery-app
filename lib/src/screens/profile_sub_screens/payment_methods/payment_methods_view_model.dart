import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/bottom_sheet/payment_bottom_sheet.dart';

class PaymentMethodsViewModel extends GetxController {
  void onCardTap() {
    Utils.showGetModal(
      isDismissible: true,
      isScrollControlled: true,
      child: const PaymentBottomSheet(),
    );
  }
}
