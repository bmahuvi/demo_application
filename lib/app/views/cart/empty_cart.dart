import 'package:demo_application/app/provider/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({super.key});

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                child: Icon(
                  Icons.remove_shopping_cart_outlined,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  size: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Cart is empty',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Consumer<BottomNavProvider>(
                builder: (context, nav, child) => FilledButton(
                    onPressed: () {
                      nav.defaultSelectedTab = 0;
                    },
                    child: const Center(child: Text('Start shopping')))),
          )
        ],
      ),
    );
  }
}
