import 'package:demo_application/app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'star_rating.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Center(
                    child: Text(
                  'Sort Products',
                  style: Theme.of(context).textTheme.titleLarge,
                )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(child: Text('Sort by Price')),
            ),
            const SizedBox(
              height: 12,
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 1,
                dense: true,
                groupValue: product.selectedRadioTile,
                onChanged: (newValue) {
                  product.changeRadioGroupValue(newValue ?? 0);
                },
                title: const Text('Ascending'),
                subtitle: const Text('Low to High'),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 2,
                dense: true,
                groupValue: product.selectedRadioTile,
                onChanged: (newValue) {
                  product.changeRadioGroupValue(newValue ?? 0);
                },
                title: const Text('Descending'),
                subtitle: const Text('High to Low'),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: Consumer<ProductProvider>(
                    builder: (_, product, child) => FilledButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: product.selectedRadioTile == 0
                            ? null
                            : () {
                                product.sortProducts();
                                Scaffold.of(context).closeEndDrawer();
                              },
                        child: const Text('Apply')))),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(child: Text('Sort by Rating')),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 5,
                dense: true,
                groupValue: product.selectedRating,
                onChanged: (newValue) {
                  product.changeRatingRadio(newValue ?? 0);
                  product.sortByRating();
                  Navigator.pop(context);
                },
                title: const StarRating(
                  rating: 5.0,
                  size: 20,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 4,
                dense: true,
                groupValue: product.selectedRating,
                onChanged: (newValue) {
                  product.changeRatingRadio(newValue ?? 0);
                  product.sortByRating();
                  Navigator.pop(context);
                },
                title: const StarRating(
                  rating: 4.0,
                  size: 20,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 3,
                dense: true,
                groupValue: product.selectedRating,
                onChanged: (newValue) {
                  product.changeRatingRadio(newValue ?? 0);
                  product.sortByRating();
                  Navigator.pop(context);
                },
                title: const StarRating(
                  rating: 3.0,
                  size: 20,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 2,
                dense: true,
                groupValue: product.selectedRating,
                onChanged: (newValue) {
                  product.changeRatingRadio(newValue ?? 0);
                  product.sortByRating();
                  Navigator.pop(context);
                },
                title: const StarRating(
                  rating: 2.0,
                  size: 20,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, product, child) => RadioListTile<int>(
                value: 1,
                dense: true,
                groupValue: product.selectedRating,
                onChanged: (newValue) {
                  product.changeRatingRadio(newValue ?? 0);
                  product.sortByRating();
                  Navigator.pop(context);
                },
                title: const StarRating(
                  rating: 1.0,
                  size: 20,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            const Divider(),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: Consumer<ProductProvider>(
                    builder: (_, product, child) => FilledButton(
                        onPressed: () {
                          product.reset();
                          Scaffold.of(context).closeEndDrawer();
                        },
                        child: const Text('Reset')))),
          ]),
        ),
      ),
    );
  }
}
