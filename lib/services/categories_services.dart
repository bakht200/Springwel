import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:springwel/model/categories_model.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class CategoriesServices {
  static CategoriesServices? _instance;

  CategoriesServices._();

  static CategoriesServices? get instance {
    _instance ??= CategoriesServices._();

    return _instance;
  }

  fetchCategories() async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://woocommerce-647788-2807778.cloudwaysapps.com",
        consumerKey: "ck_4b5aba919eb2fe5bba8370cb06ab63f8c2368ba3",
        consumerSecret: "cs_6b1b39890f21559d1571d66c8dd12fab06d90191");

    var products = await wooCommerceAPI.getAsync("products/categories");

    return products;
  }
}
