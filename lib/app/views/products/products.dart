import 'package:demo_application/app/provider/product_provider.dart';
import 'package:demo_application/app/widgets/grid_shimmer.dart';
import 'package:demo_application/app/widgets/product_card.dart';
import 'package:demo_application/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_drawer.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('DemoAPP'),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, value, child) => IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: const Icon(Icons.search_outlined)),
          ),
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.filter_alt_outlined))
        ],
      ),
      endDrawer: const AppDrawer(),
      body: Consumer<ProductProvider>(
          builder: (context, productModel, child) => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: productModel.isLoading
                    ? const Center(
                        child: GridShimmer(),
                      )
                    : productModel.products!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                  radius: 40,
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 40,
                                  )),
                              const SizedBox(height: 16),
                              Text(
                                'No products to display',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 180,
                            ),
                            itemCount: productModel.products!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = productModel.products![index];
                              return ProductCard(product: product);
                            },
                          ),
              )),
    );
  }
}

class Search extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search by title';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    List<ProductModel> suggestions = provider.products!
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => ProductCard(product: suggestions[index]),
      itemCount: suggestions.length,
    );
  }
}
