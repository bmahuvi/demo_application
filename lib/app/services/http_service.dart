import 'dart:async';
import 'dart:io';

import 'package:demo_application/models/products_model.dart';
import 'package:demo_application/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<List<ProductModel>?> getProducts() async {
    List<ProductModel>? productModel;
    try {
      final response = await http
          .get(Uri.parse(Uri.encodeFull(AppData.baseUrl)))
          .timeout(AppData.httpTimeout);

      if (response.statusCode == 200) {
        productModel = productModelFromJson(response.body);
      }
    } on SocketException catch (e) {
      print(e.message);
      return Future.error(e);
    }
    return productModel;
  }
}
