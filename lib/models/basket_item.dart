class BasketItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  BasketItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}