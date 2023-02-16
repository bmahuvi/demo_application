import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/app/controllers/products_controller.dart';
import 'package:demo_app/app/widgets/star_rating.dart';
import 'package:demo_app/models/products_model.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/image_container.dart';

class ProductDetail extends GetView<ProductsController> {
  const ProductDetail({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details'),
      ),
      body: Container(
        width: size.width,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: size.width - 100,
                  height: 280,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 7),
                            blurRadius: 8,
                            color: context.theme.colorScheme.shadow
                                .withOpacity(0.2)),
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: 'HERO_${model.id}',
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CachedNetworkImage(
                          imageUrl: model.image,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.hide_image_outlined,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  model.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'USD ${model.price}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 32,
                  right: 32,
                ),
                child: FilledButton(
                    onPressed: () {
                      controller.itemCount(1);
                      controller.selectedProduct(model);
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return GetBuilder<ProductsController>(
                                builder: (productsController) {
                              return Container(
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'USD ${model.price}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: productsController
                                                        .itemCount.value ==
                                                    1
                                                ? null
                                                : () {
                                                    productsController
                                                        .decrementCartItems();
                                                  },
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              size: 40,
                                            )),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          width: 80,
                                          height: 40,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade500,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Center(
                                              child: Text(
                                            '${productsController.itemCount.value}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87),
                                          )),
                                        ),
                                        IconButton(
                                            onPressed: productsController
                                                        .itemCount.value ==
                                                    AppData.maxCartValue
                                                ? null
                                                : () {
                                                    productsController
                                                        .incrementCartItems();
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
                                        'TOTAL \$ ${model.price * controller.itemCount.value}',
                                        style: TextStyle(
                                            color:
                                                context.theme.colorScheme.error,
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      width: 180,
                                      child: FilledButton.icon(
                                          onPressed: () {
                                            controller.addToCart();
                                            if (controller.cartItems.indexWhere(
                                                    (element) =>
                                                        element.id ==
                                                        model.id) !=
                                                -1) {
                                              Get.back();
                                            }
                                          },
                                          icon: const Icon(
                                              Icons.add_shopping_cart_outlined),
                                          label: Text(
                                              'Add ${controller.itemCount} ${controller.itemCount.value == 1 ? ' item' : ' items'}')),
                                    )
                                  ],
                                ),
                              );
                            });
                          });
                    },
                    child: const Center(child: Text('Add to Cart'))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  'More information',
                  style: context.theme.textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Text(
                      'Category',
                      style: context.theme.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text(model.category.toUpperCase())),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Text(
                      'Rating',
                      style: context.theme.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          StarRating(
                            rating: model.rating.rate,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(' (${model.rating.count})')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: context.theme.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(child: Text(model.description)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
