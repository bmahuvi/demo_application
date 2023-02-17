import 'dart:async';

import 'package:demo_application/models/products_model.dart';
import 'package:demo_application/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<List<ProductModel>?> getProducts() async {
    List<ProductModel>? productModel;
    try {
      final response = await http
          .get(Uri.parse(AppData.baseUrl))
          .timeout(AppData.httpTimeout);

      if (response.statusCode == 200) {
        productModel = productModelFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return productModel;
  }
}
