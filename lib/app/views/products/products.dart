import 'package:demo_application/app/provider/product_provider.dart';
import 'package:demo_application/app/views/products/product_details.dart';
import 'package:demo_application/app/widgets/grid_shimmer.dart';
import 'package:demo_application/app/widgets/image_container.dart';
import 'package:demo_application/app/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_drawer.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).fetchData();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DemoAPP'),
        actions: [
          IconButton(
              onPressed: () {
                // _scaffoldKey.currentState!.isDrawerOpen;
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.filter_alt_outlined))
        ],
      ),
      endDrawer: const AppDrawer(),
      body: Consumer<ProductProvider>(
          builder: (context, productModel, child) => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: !productModel.isLoading
                    ? const Center(
                        child: GridShimmer(),
                      )
                    : productModel.isError
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  child: Icon(
                                    Icons.wifi_off_outlined,
                                    size: 40,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'TIMEOUT: Network error occured',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              FilledButton.icon(
                                  onPressed: () {
                                    productModel.fetchData();
                                  },
                                  icon: const Icon(Icons.refresh_outlined),
                                  label: const Text('Retry')),
                            ],
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 180,
                            ),
                            itemCount: productModel.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = productModel.products[index];
                              return Card(
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProductDetails.routeName,
                                        arguments: product);
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ImageContainer(
                                              imageUrl: product.image,
                                              productId: product.id,
                                              height: 100,
                                              width: 100),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: StarRating(
                                                  rating: product.rating.rate,
                                                ),
                                              ),
                                              Text(' (${product.rating.count})')
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0, right: 8),
                                              child: Text(
                                                product.title,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Text(
                                                'USD ${product.price}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              )),
    );
  }
}
