import 'package:demo_application/app/app.dart';
import 'package:demo_application/app/views/cart/cart.dart';
import 'package:flutter/cupertino.dart';

import '../app/views/products/product_details.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    ProductDetails.routeName: (_) => const ProductDetails(),
    App.routeName: (_) => const App(),
    Cart.routeName: (_) => const Cart(),
  };
}
