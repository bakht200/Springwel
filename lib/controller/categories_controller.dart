import 'package:flutter/material.dart';
import 'package:springwel/model/categories_model.dart';
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

  CategoryProvider() {
    fetchCategoriesData();
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
}
