import 'package:demo_app/app/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyCart extends GetView<AppController> {
  const EmptyCart({super.key});

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
                backgroundColor: context.theme.colorScheme.errorContainer,
                child: Icon(
                  Icons.remove_shopping_cart_outlined,
                  color: context.theme.colorScheme.onErrorContainer,
                  size: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Cart is empty',
                style: context.theme.textTheme.titleLarge,
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: FilledButton(
                onPressed: () {
                  controller.defaultSelectedTab(0);
                },
                child: const Center(child: Text('Start shopping'))),
          )
        ],
      ),
    );
  }
}
