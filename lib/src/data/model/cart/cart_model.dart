class CartModel {
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  int productQuantity;
  double productSubTotal;
  final double productTax;
  final double productDeliveryFee;

  CartModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.productSubTotal,
    required this.productTax,
    required this.productDeliveryFee,
  });

  // Method to update the subtotal based on the product quantity and price
  void updateSubTotal() {
    productSubTotal = (productPrice * productQuantity);
  }

  // Optionally: Convert the CartModel instance to a map, useful for storing data in a database or sending to an API
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productSubTotal': productSubTotal,
      'productTax': productTax,
      'productDeliveryFee': productDeliveryFee,
    };
  }

  // Optionally: Create a CartModel from a map, useful when retrieving data from a database or an API
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'],
      productName: map['productName'],
      productImage: map['productImage'],
      productPrice: map['productPrice'],
      productQuantity: map['productQuantity'],
      productSubTotal: map['productSubTotal'],
      productTax: map['productTax'],
      productDeliveryFee: map['productDeliveryFee'],
    );
  }
}
