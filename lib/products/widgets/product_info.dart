import 'package:appdev_assign2/products/api/products_model.dart';
import 'package:appdev_assign2/products/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "\$${product.price}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              RatingStars(rating: product.rating),
              const SizedBox(width: 6),
              Text("(${product.ratingCount})",
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
