import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  const CartBadge(
      {super.key,
      required this.label,
      required this.isLabelVisible,
      required this.icon});
  final String label;
  final bool isLabelVisible;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Badge(
      alignment: const AlignmentDirectional(22, -8),
      label: Text(label),
      largeSize: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      isLabelVisible: isLabelVisible,
      child: Icon(icon),
    );
  }
}
