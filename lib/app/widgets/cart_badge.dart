import 'package:demo_application/app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Badge(
          alignment: const AlignmentDirectional(22, -8),
          label: Text('${cart.cartItems.length}'),
          largeSize: 18,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          isLabelVisible: cart.cartItems.isNotEmpty,
          child: child,
        );
      },
      child: Icon(icon),
    );
  }
}
