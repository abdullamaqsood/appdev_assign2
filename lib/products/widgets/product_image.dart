import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_assign2/products/api/products_provider.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final isOffline = Provider.of<ProductProvider>(context).isOffline;

    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        image: isOffline
            ? null
            : DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {}, // prevents crash
              ),
      ),
      child: isOffline
          ? const Center(
              child:
                  Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            )
          : null,
    );
  }
}
