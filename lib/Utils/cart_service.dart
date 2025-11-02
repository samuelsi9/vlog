import 'package:vlog/Models/model.dart';
import 'package:flutter/material.dart';

class CartItem {
  final itemModel item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get totalPrice => (item.price * quantity).toDouble();
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice.toDouble());

  void addToCart(itemModel item) {
    final existingIndex = _cartItems.indexWhere(
      (cartItem) =>
          cartItem.item.name == item.name && cartItem.item.image == item.image,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(item: item));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void updateQuantity(CartItem cartItem, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItem);
    } else {
      cartItem.quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  bool isInCart(itemModel item) {
    return _cartItems.any(
      (cartItem) =>
          cartItem.item.name == item.name && cartItem.item.image == item.image,
    );
  }
}
