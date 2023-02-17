import 'package:demo_application/models/products_model.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _products = [];
  double _totalPrice = 0.0;
  String x = '1';

  double get totalPrice => _totalPrice;

  /*
  CART MANAGEMENT
  */

  int itemCount = 1;
  final cartItems = <CartModel>[];

  // Increment item counter
  void incrementCartItems() {
    itemCount++;
    notifyListeners();
  }

  // Decrement item counter
  void decrementCartItems() {
    itemCount--;
    notifyListeners();
  }

  // Add items to cart
  void addToCart(ProductModel item) {
    cartItems.add(CartModel(
        id: item.id,
        quantity: itemCount,
        title: item.title,
        price: item.price,
        image: item.image));
    _totalPrice += item.price * itemCount;
    notifyListeners();
  }

  //Delete all items from the cart
  void deleteCartItems() {
    cartItems.clear();
    _totalPrice = 0.0;
    notifyListeners();
  }

  //Delete cart item by product id
  void deleteItemById({required CartModel item}) {
    // Check if an item exists then remove it
    if (cartItems.indexWhere((element) => element.id == item.id) != -1) {
      cartItems.remove(item);
      _totalPrice -= item.price * itemCount;
    }
    notifyListeners();
  }

  //Update cart item quantity
  void updateItemCount(
      {required CartModel item,
      required String action,
      required int currentValue}) {
    //Check if an item exists in cart items
    if (cartItems.indexWhere((element) => element.id == item.id) != -1) {
      if (action == 'increase') {
        currentValue++;

        // Find its index and replace with new data
        cartItems[cartItems.indexWhere((element) => element.id == item.id)] =
            CartModel(
                id: item.id,
                quantity: currentValue,
                title: item.title,
                price: item.price,
                image: item.image);
        _totalPrice += item.price * currentValue;
        notifyListeners();
      } else {
        currentValue--;
        cartItems.removeWhere((element) => element.id == item.id);
        cartItems.add(CartModel(
            id: item.id,
            quantity: currentValue,
            title: item.title,
            price: item.price,
            image: item.image));
        _totalPrice -= item.price * currentValue;
        notifyListeners();
      }
    }
  }
}
