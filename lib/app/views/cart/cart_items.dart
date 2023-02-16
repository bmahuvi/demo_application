import 'package:demo_app/app/controllers/products_controller.dart';
import 'package:demo_app/app/widgets/image_container.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(builder: (controller) {
      return ListView.separated(
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
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
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text('USD ${item.price * item.quantity}'),
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
                                                        controller
                                                            .selectedCartItem(
                                                                item);
                                                        controller
                                                            .updateItemCount(
                                                                id: item.id,
                                                                action:
                                                                    'decrease',
                                                                currentValue: item
                                                                    .quantity);
                                                      },
                                                icon: const Icon(Icons.remove)),
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
                                                onPressed:
                                                    item.quantity ==
                                                            AppData.maxCartValue
                                                        ? null
                                                        : () {
                                                            controller
                                                                .selectedCartItem(
                                                                    item);
                                                            controller.updateItemCount(
                                                                id: item.id,
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
                            controller.deleteItemById(id: item.id);
                          },
                          icon: const Icon(Icons.delete_outline)),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: controller.cartItems.length);
    });
  }
}
