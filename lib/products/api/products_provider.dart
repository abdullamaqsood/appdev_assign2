import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../api/products_model.dart';
import '../api/product_database.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isOffline = false; // 👈 NEW
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    setLoading(true);

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity != ConnectivityResult.none) {
      isOffline = false;
      const url = 'https://fakestoreapi.com/products';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body) as List;
          _products =
              jsonData.map((item) => ProductModel.fromJson(item)).toList();

          await ProductDatabase.instance.insertProducts(_products);
        }
      } catch (e) {
        print("API fetch error: $e");
        _products = await ProductDatabase.instance.getProducts();
        isOffline = true;
      }
    } else {
      isOffline = true;
      _products = await ProductDatabase.instance.getProducts();
    }

    setLoading(false);
    notifyListeners();
  }
}
