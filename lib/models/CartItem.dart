import 'package:flutter/foundation.dart';
import 'Product.dart';

// Cart Item Model
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}