import 'package:flutter/material.dart';

import 'widgets/cart_badge.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (indexOfSelectedTab) {
            setState(() {
              _selectedIndex = indexOfSelectedTab;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore),
                label: 'Explore'),
            NavigationDestination(
                icon: CartBadge(
                    label: '2',
                    icon: Icons.shopping_cart_outlined,
                    isLabelVisible: true),
                selectedIcon: CartBadge(
                    label: '2',
                    icon: Icons.shopping_cart,
                    isLabelVisible: true),
                label: 'Cart'),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings'),
          ]),
    );
  }
}
