import 'package:demo_application/app/views/cart/cart.dart';
import 'package:demo_application/app/views/products/products.dart';
import 'package:demo_application/app/views/settings/settings.dart';
import 'package:flutter/cupertino.dart';

class BottomNavProvider with ChangeNotifier {
  /*
  This value is used to control the selected tab
  in the bottom navigation bar
  */
  int defaultSelectedTab = 0;

  /*
  List containing screens to show in the main page
  based on selected tab
  */
  final List<Widget> screens = [
    const Products(),
    const Cart(),
    const Settings(),
  ];

  //function to return a screen from screens above
  Widget get screen => screens[defaultSelectedTab];

  //function to change navigation tab
  void changeTab({required int currentTabIndex}) {
    defaultSelectedTab = currentTabIndex;
    notifyListeners();
  }
}
