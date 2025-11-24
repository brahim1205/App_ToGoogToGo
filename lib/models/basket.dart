class Basket {
  final String id;
  final String storeId;
  final String name;
  final String description;
  final double originalPrice;
  final double discountedPrice;
  final DateTime pickupTime;
  final int availableQuantity;
  final List<String> images;
  final String category;

  Basket({
    required this.id,
    required this.storeId,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.pickupTime,
    required this.availableQuantity,
    required this.images,
    required this.category,
  });

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      id: json['id'],
      storeId: json['storeId'],
      name: json['name'],
      description: json['description'],
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
      pickupTime: DateTime.parse(json['pickupTime']),
      availableQuantity: json['availableQuantity'],
      images: List<String>.from(json['images'] ?? []),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'name': name,
      'description': description,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'pickupTime': pickupTime.toIso8601String(),
      'availableQuantity': availableQuantity,
      'images': images,
      'category': category,
    };
  }
}

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
      price: (json['price'] as num).toDouble(),
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
