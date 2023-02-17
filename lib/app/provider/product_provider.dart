import 'package:demo_application/app/services/http_service.dart';
import 'package:demo_application/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel>? products;
  List<ProductModel>? duplicate;
  bool isLoading = false;
  bool isError = false;
  Services services = Services();

  void fetchData() async {
    isLoading = true;
    try {
      products = (await services.getProducts())!;
      duplicate = products;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
    }
  }

  /*
  Sorting products by price
  */
  int selectedRadioTile = 0;

  void changeRadioGroupValue(int newValue) {
    selectedRadioTile = newValue;
    notifyListeners();
  }

  //do the sorting by price
  void sortProducts() {
    if (selectedRadioTile != 0) {
      selectedRadioTile == 1
          ? products!.sort((a, b) => a.price.compareTo(b.price))
          : products!.sort((a, b) => b.price.compareTo(a.price));
      notifyListeners();
    }
  }

  /*
  Sorting products by rating
  */
  int selectedRating = 0;

  void changeRatingRadio(int newValue) {
    selectedRating = newValue;
    notifyListeners();
  }

  //do the sorting by rating
  void sortByRating() {
    if (selectedRating != 0) {
      products = duplicate!
          .where((element) =>
              element.rating.rate >= selectedRating &&
              element.rating.rate < selectedRating + 1)
          .toList();
      notifyListeners();
    }
  }

  // Reset
  void reset() {
    products = duplicate;
    selectedRating = 0;
    selectedRadioTile = 0;
    notifyListeners();
  }
}
