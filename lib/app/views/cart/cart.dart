import 'package:demo_application/app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_items.dart';
import 'empty_cart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  static const routeName = '/cart';

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<CartProvider>(
            builder: (_, cart, child) => Text(cart.cartItems.isEmpty
                ? 'CART'
                : 'CART (${cart.cartItems.length})')),
        actions: [
          Consumer<CartProvider>(
              builder: (context, cart, child) => IconButton(
                  onPressed: cart.cartItems.isEmpty
                      ? null
                      : () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: const Text(
                                        'Are you sure you want to clear the cart?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('No'))
                                    ],
                                  )).then((value) {
                            if (value) {
                              cart.deleteCartItems();
                            } else {}
                          });
                        },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  )))
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
          builder: (_, cart, child) => cart.cartItems.isEmpty
              ? const SizedBox.shrink()
              : BottomAppBar(
                  elevation: 11,
                  height: 50,
                  surfaceTintColor: Theme.of(context).colorScheme.secondary,
                  child: Center(
                    child: Text(
                      'TOTAL USD ${(cart.totalPrice).toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 16),
                    ),
                  ),
                )),
      body: Consumer<CartProvider>(
          builder: (context, cart, child) =>
              cart.cartItems.isEmpty ? const EmptyCart() : const CartItems()),
    );
  }
}
