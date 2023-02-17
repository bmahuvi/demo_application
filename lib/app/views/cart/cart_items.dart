import 'package:demo_application/app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../widgets/image_container.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (_, cart, child) => ListView.separated(
            itemBuilder: (context, index) {
              final item = cart.cartItems[index];
              return Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          ImageContainer(
                              imageUrl: item.image,
                              productId: item.id,
                              height: 90,
                              width: 90),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'USD ${(item.price * item.quantity).toStringAsFixed(2)}'),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                        ),
                                        height: 38,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                  onPressed: item.quantity == 1
                                                      ? null
                                                      : () {
                                                          cart.updateItemCount(
                                                              item: item,
                                                              action:
                                                                  'decrease',
                                                              currentValue: item
                                                                  .quantity);
                                                        },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                            ),
                                            const VerticalDivider(),
                                            SizedBox(
                                              width: 20,
                                              child: Center(
                                                  child:
                                                      Text('${item.quantity}')),
                                            ),
                                            const VerticalDivider(),
                                            Expanded(
                                              child: IconButton(
                                                  onPressed: item.quantity ==
                                                          AppData.maxCartValue
                                                      ? null
                                                      : () {
                                                          cart.updateItemCount(
                                                              item: item,
                                                              action:
                                                                  'increase',
                                                              currentValue: item
                                                                  .quantity);
                                                        },
                                                  icon: const Icon(Icons.add)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              cart.deleteItemById(item: item);
                            },
                            icon: const Icon(Icons.delete_outline)),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cart.cartItems.length));
  }
}
