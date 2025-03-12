import 'package:appdev_assign2/products/api/products_model.dart';
import 'package:appdev_assign2/products/widgets/product_image.dart';
import 'package:appdev_assign2/products/widgets/product_info.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImage(imageUrl: product.image),
            ProductInfo(product: product),
          ],
        ),
      ),
    );
  }
}
