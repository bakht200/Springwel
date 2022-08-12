import 'package:flutter/material.dart';
import 'package:springwel/model/categories_model.dart';
import 'package:springwel/model/product_detail_model.dart';
import 'package:springwel/model/product_model.dart';
import 'package:springwel/services/categories_services.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class ProductProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CategoriesModel> categoriesList = [];
  List<ProductModel> productList = [];

  int productId = 0;

  ProductProvider() {
    fetchCategoriesProduct();
  }

  HomeState get homestate => _homeState;

  Future<void> fetchCategoriesProduct() async {
    _homeState = HomeState.loading;
    try {
      final List<dynamic> getProductList =
          await CategoriesServices.instance?.fetchProducts();

      productList =
          getProductList.map((obj) => ProductModel.fromJson(obj)).toList();

      _homeState = HomeState.loaded;
    } catch (e) {
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}
