import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appdev_assign2/products/api/products_model.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    setLoading(true);
    const url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        _products =
            jsonData.map((item) => ProductModel.fromJson(item)).toList();
      }
    } catch (e) {
      print("Error fetching products: $e");
    }

    setLoading(false);
  }
}
