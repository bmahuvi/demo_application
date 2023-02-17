import 'package:demo_application/app/provider/cart_provider.dart';
import 'package:demo_application/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'image_container.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key, required this.model}) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (_, cart, child) => Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    child: Container(
                      height: 6,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ImageContainer(
                          imageUrl: model.image,
                          productId: model.id,
                          height: 80,
                          width: 80),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'USD ${model.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: cart.itemCount == 1
                              ? null
                              : () {
                                  cart.decrementCartItems();
                                },
                          icon: const Icon(
                            Icons.remove_circle,
                            size: 40,
                          )),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 80,
                        height: 40,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade500, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black87),
                        )),
                      ),
                      IconButton(
                          onPressed: cart.itemCount == AppData.maxCartValue
                              ? null
                              : () {
                                  cart.incrementCartItems();
                                },
                          icon: const Icon(
                            Icons.add_circle,
                            size: 40,
                          )),
                    ],
                  ),
                  const Divider(
                    indent: 64,
                    endIndent: 64,
                  ),
                  Align(
                    child: Text(
                      'TOTAL \$ ${(model.price * cart.itemCount).toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Divider(
                    indent: 64,
                    endIndent: 64,
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    width: 180,
                    child: FilledButton.icon(
                        onPressed: () {
                          cart.addToCart(model);
                          if (cart.cartItems.indexWhere(
                                  (element) => element.id == model.id) !=
                              -1) {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                        label: Text(
                            'Add ${cart.itemCount} ${cart.itemCount == 1 ? ' item' : ' items'}')),
                  )
                ],
              ),
            ));
  }
}
