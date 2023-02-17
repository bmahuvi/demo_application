import 'package:demo_application/app/services/http_service.dart';
import 'package:demo_application/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  late List<ProductModel> products;
  bool isLoading = false;
  bool isError = false;
  Services services = Services();

  void fetchData() async {
    isLoading = true;
    try {
      products = (await services.getProducts())!;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
    }
  }
}
