import 'dart:convert';

import 'package:demo_application/models/products_model.dart';
import 'package:demo_application/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<ProductModel?> getProducts() async {
  ProductModel? productModel;
  try {
    final response = await http
        .get(Uri.parse(Uri.encodeFull(AppData.baseUrl)))
        .timeout(AppData.httpTimeout);
    // 200 is for success
    if (response.statusCode == 200) {
      productModel = ProductModel.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
  return productModel;
}
