class Order {
  final String id;
  final String imageUrl;
  final DateTime dateOfOrder;
  final String timeOfDelivery;
  final int quantity;
  final String deliveryAddress;
  final String title;
  final double subtotal;
  final double taxes;
  final double deliveryFee;
  final double total;
  final bool isDelivered;

  Order({
    required this.id,
    required this.imageUrl,
    required this.dateOfOrder,
    required this.timeOfDelivery,
    required this.quantity,
    required this.deliveryAddress,
    required this.title,
    required this.subtotal,
    required this.taxes,
    required this.deliveryFee,
    required this.total,
    required this.isDelivered,
  });

  String get formattedDate => "${dateOfOrder.day}/${dateOfOrder.month}/${dateOfOrder.year}";
  String get formattedTime => timeOfDelivery;

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
      id: data['id'],
      imageUrl: data['imageUrl'],
      dateOfOrder: DateTime.parse(data['dateOfOrder']),
      timeOfDelivery: data['timeOfDelivery'],
      quantity: data['quantity'],
      deliveryAddress: data['deliveryAddress'],
      title: data['title'],
      subtotal: data['subtotal'].toDouble(),
      taxes: data['taxes'].toDouble(),
      deliveryFee: data['deliveryFee'].toDouble(),
      total: data['total'].toDouble(),
      isDelivered: data['isDelivered'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'dateOfOrder': dateOfOrder.toIso8601String(),
      'timeOfDelivery': timeOfDelivery,
      'quantity': quantity,
      'deliveryAddress': deliveryAddress,
      'title': title,
      'subtotal': subtotal,
      'taxes': taxes,
      'deliveryFee': deliveryFee,
      'total': total,
      'isDelivered': isDelivered,
    };
  }
}