class User {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? profileImage;
  final List<String> favoriteStores;
  final List<String> orderHistory;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.profileImage,
    this.favoriteStores = const [],
    this.orderHistory = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      profileImage: json['profileImage'],
      favoriteStores: List<String>.from(json['favoriteStores'] ?? []),
      orderHistory: List<String>.from(json['orderHistory'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profileImage': profileImage,
      'favoriteStores': favoriteStores,
      'orderHistory': orderHistory,
    };
  }
}
