import 'package:flutter/material.dart';
import 'package:dailycatch/models/basket_item.dart';
import 'package:dailycatch/models/user.dart';

class AppState with ChangeNotifier {
  User? _currentUser;
  List<BasketItem> _cartItems = [];

  // Getters
  User? get currentUser => _currentUser;
  List<BasketItem> get cartItems => _cartItems;

  double get cartTotal => _cartItems.fold(
      0.0, (total, item) => total + ((item?.price ?? 0) * (item?.quantity ?? 0)));

  int get cartItemCount => _cartItems.fold(
      0, (total, item) => total + (item?.quantity ?? 0));

  // User management
  void setCurrentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearCurrentUser() {
    _currentUser = null;
    _cartItems.clear();
    notifyListeners();
  }

  // Cart management
  void addToCart(BasketItem item) {
    final existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.productId == item.productId,
    );

    if (existingIndex >= 0) {
      // Update quantity if item exists
      final existingItem = _cartItems[existingIndex];
      _cartItems[existingIndex] = BasketItem(
        productId: existingItem.productId,
        productName: existingItem.productName,
        quantity: existingItem.quantity + item.quantity,
        price: existingItem.price,
      );
    } else {
      // Add new item
      _cartItems.add(item);
    }

    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void updateCartItemQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      final existingItem = _cartItems[index];
      _cartItems[index] = BasketItem(
        productId: existingItem.productId,
        productName: existingItem.productName,
        quantity: newQuantity,
        price: existingItem.price,
      );
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Check if item is in cart
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.productId == productId);
  }

  // Get quantity of specific item in cart
  int getCartItemQuantity(String productId) {
    final item = _cartItems.firstWhere(
      (item) => item.productId == productId,
      orElse: () => BasketItem(productId: '', productName: '', quantity: 0, price: 0.0),
    );
    return item.quantity;
  }
}