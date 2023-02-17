import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_application/app/provider/providers.dart';
import 'package:demo_application/app/views/cart/cart.dart';
import 'package:demo_application/app/widgets/star_rating.dart';
import 'package:demo_application/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_bottom_sheet.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductModel model =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              alignment: const AlignmentDirectional(26, 0),
              label: Text('${cart.cartItems.length}'),
              largeSize: 18,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              isLabelVisible: cart.cartItems.isNotEmpty,
              child: child,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Cart.routeName);
                },
                icon: const Icon(Icons.shopping_cart_outlined)),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
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
                  width: size.width - 150,
                  height: 240,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 7),
                            blurRadius: 8,
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
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
                child: Consumer<CartProvider>(
                    builder: (_, cart, child) => cart.cartItems.indexWhere(
                                (element) => element.id == model.id) !=
                            -1
                        ? Column(
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Cart.routeName);
                                  },
                                  child: const Center(
                                      child: Text('View items in cart'))),
                              FilledButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      foregroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .onSecondary)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Center(child: Text('Add more'))),
                            ],
                          )
                        : FilledButton(
                            onPressed: () {
                              cart.itemCount = 1;
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return CustomBottomSheet(model: model);
                                  });
                            },
                            child: const Center(child: Text('Add to Cart')))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  'More information',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.labelLarge,
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
                      style: Theme.of(context).textTheme.labelLarge,
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
                      style: Theme.of(context).textTheme.labelLarge,
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
