import 'package:flutter/material.dart';
import 'package:springwel/model/product_model.dart';
import 'package:springwel/services/categories_services.dart';

import '../model/product_detail_model.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class ProductDetailProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;

  List<ProductDetailModel> productData = [];
  late final int productId;

  HomeState get homestate => _homeState;
}
