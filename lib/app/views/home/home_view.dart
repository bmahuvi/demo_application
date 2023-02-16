import 'package:demo_app/app/controllers/app_controller.dart';
import 'package:demo_app/app/controllers/products_controller.dart';
import 'package:demo_app/app/widgets/cart_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<AppController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screen),
      bottomNavigationBar: Obx(() => NavigationBar(
              selectedIndex: controller.defaultSelectedTab.value,
              onDestinationSelected: (indexOfSelectedTab) {
                controller.defaultSelectedTab(indexOfSelectedTab);
              },
              destinations: [
                const NavigationDestination(
                    icon: Icon(Icons.explore_outlined),
                    selectedIcon: Icon(Icons.explore),
                    label: 'Explore'),
                NavigationDestination(
                    icon: GetBuilder<ProductsController>(
                        builder: (productController) => CartBadge(
                            label:
                                productController.cartItems.length.toString(),
                            isLabelVisible:
                                productController.cartItems.isNotEmpty)),
                    selectedIcon: GetBuilder<ProductsController>(
                        builder: (productController) => CartBadge(
                            label:
                                productController.cartItems.length.toString(),
                            isLabelVisible:
                                productController.cartItems.isNotEmpty)),
                    label: 'Cart'),
                const NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings'),
              ])),
    );
  }
}
