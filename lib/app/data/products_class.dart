import 'package:demo_application/app/services/http_service.dart';
import 'package:demo_application/models/products_model.dart';
import 'package:flutter/cupertino.dart';

class ProductData extends ChangeNotifier{
  ProductModel? product;
  bool fetchingData=false;
  fetchData() async{
    fetchingData=true;
    product=(await getProducts());
    fetchingData=false;
    notifyListeners();
  }
}