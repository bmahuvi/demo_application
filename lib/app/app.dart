import 'package:demo_application/app/provider/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/cart_badge.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const routeName = '/app';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavProvider>(
          builder: (context, value, child) => value.screen),
      bottomNavigationBar:
          Consumer<BottomNavProvider>(builder: (context, value, child) {
        return NavigationBar(
            selectedIndex: value.defaultSelectedTab,
            onDestinationSelected: (indexOfSelectedTab) {
              value.changeTab(currentTabIndex: indexOfSelectedTab);
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: 'Explore'),
              NavigationDestination(
                  icon: CartBadge(icon: Icons.shopping_cart_outlined),
                  selectedIcon: CartBadge(icon: Icons.shopping_cart),
                  label: 'Cart'),
              NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings'),
            ]);
      }),
    );
  }
}
