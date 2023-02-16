import 'package:demo_app/app/controllers/products_controller.dart';
import 'package:demo_app/app/views/products/product_details.dart';
import 'package:demo_app/app/widgets/image_container.dart';
import 'package:demo_app/app/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/grid_shimmer.dart';

class ProductsView extends StatelessWidget {
  ProductsView({super.key});

  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DemoAPP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: controller.obx(
            (data) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 180,
                  ),
                  itemCount: data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = data[index];
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ProductDetail(model: product));
                        },
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageContainer(
                                    imageUrl: product.image,
                                    productId: product.id,
                                    height: 100,
                                    width: 100),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text(
                                      'USD ${product.price}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
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
            onLoading: const GridShimmer(),
            onError: (error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: context.theme.colorScheme.error,
                      size: 48,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(error.toString())
                  ],
                ),
            onEmpty: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.info_outline,
                  size: 48,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('No data to display')
              ],
            )),
      ),
    );
  }
}
