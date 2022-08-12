import 'package:flutter/material.dart';
import 'package:springwel/model/categories_model.dart';
import 'package:springwel/model/product_model.dart';
import 'package:springwel/services/categories_services.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class CategoryProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CategoriesModel> categoriesList = [];
  List<ProductModel> productList = [];

  CategoryProvider() {
    fetchCategoriesData();
    fetchCategoriesProduct();
  }

  HomeState get homestate => _homeState;

  Future<void> fetchCategoriesData() async {
    _homeState = HomeState.loading;
    try {
      final List<dynamic> getCategoriesList =
          await CategoriesServices.instance?.fetchCategories();

      categoriesList = getCategoriesList
          .map((obj) => CategoriesModel.fromJson(obj))
          .toList();

      _homeState = HomeState.loaded;
    } catch (e) {
      _homeState = HomeState.error;
    }
    notifyListeners();
  }

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
