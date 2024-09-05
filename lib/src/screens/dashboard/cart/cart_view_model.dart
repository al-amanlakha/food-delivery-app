import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_values.dart';
import '../../../data/model/cart/cart_model.dart';
import '../../checkout/checkout_view.dart';
import '../../checkout/checkout_view_model.dart';

class CartViewModel extends GetxController {
  List<CartModel> cartList = [
    CartModel(
      productId: "R001",
      productName: "Classic Tomato Spaghetti",
      productImage: "https://example.com/images/tomato-spaghetti.jpg",
      productPrice: 12.50,
      productQuantity: 1,
      productSubTotal: 12.50,
      productTax: 1.25,
      productDeliveryFee: 2.0,
    ),
    CartModel(
      productId: "R002",
      productName: "Beef and Broccoli Stir-Fry",
      productImage: "https://example.com/images/beef-broccoli.jpg",
      productPrice: 15.75,
      productQuantity: 2,
      productSubTotal: 15.75 * 2,
      productTax: 3.15,
      productDeliveryFee: 2.5,
    ),
    CartModel(
      productId: "R003",
      productName: "Vegan Bean Chili",
      productImage: "https://example.com/images/vegan-chili.jpg",
      productPrice: 8.95,
      productQuantity: 3,
      productSubTotal: 8.9 * 3,
      productTax: 2.68,
      productDeliveryFee: 1.5,
    )
  ];

  // Method to increment the product quantity
  void incrementQuantity(CartModel model) {
    model.productQuantity += 1;
    update();
  }

  // Method to decrement the product quantity
  void decrementQuantity(CartModel model) {
    if (model.productQuantity > 1) {
      model.productQuantity -= 1;
      update();
    }
  }

  // Method to calculate and update the subtotal
  double updateSubTotal(CartModel model) {
    return model.productSubTotal = model.productPrice * model.productQuantity;
  }

  void removeItem(String productId) {
    cartList.removeWhere((item) => item.productId == productId);
    update(); // This will trigger a UI update
  }

  // Method to calculate grand subtotal
  double getGrandSubtotal() {
    return cartList.fold(0, (sum, item) => sum + item.productSubTotal);
  }

// Method to calculate total tax
  double getGrandTaxes() {
    return cartList.fold(0, (sum, item) => sum + item.productTax);
  }

// Method to calculate total delivery fee
  double getGrandDeliveryFee() {
    return cartList.fold(0, (sum, item) => sum + item.productDeliveryFee);
  }

// Method to calculate the grand total
  double getGrandTotal() {
    return getGrandSubtotal() + getGrandTaxes() + getGrandDeliveryFee();
  }

  void onCheckout() {
    Get.to(
      () => const CheckoutView(),
      curve: Curves.ease,
      transition: Transition.cupertino,
      duration:
          const Duration(milliseconds: AppValues.defaultAnimationDuration),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => CheckoutViewModel(),
          fenix: true,
        ),
      ),
    );
  }
}
