class Store {
  final String id;
  final String name;
  final String address;
  final String category;
  final List<String> images;
  final double rating;
  final double latitude;
  final double longitude;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.category,
    required this.images,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      category: json['category'],
      images: List<String>.from(json['images']),
      rating: json['rating'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'category': category,
      'images': images,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
