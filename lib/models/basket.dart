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
      originalPrice: json['originalPrice'],
      discountedPrice: json['discountedPrice'],
      pickupTime: DateTime.parse(json['pickupTime']),
      availableQuantity: json['availableQuantity'],
      images: List<String>.from(json['images']),
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
