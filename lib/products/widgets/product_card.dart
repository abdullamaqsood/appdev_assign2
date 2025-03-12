import 'package:appdev_assign2/products/api/products_model.dart';
import 'package:appdev_assign2/products/widgets/product_detail.dart';
import 'package:appdev_assign2/products/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(_pageTransition(ProductDetailScreen(product: product)));
      },
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RatingStars(rating: product.rating),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Route _pageTransition(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = animation.drive(
          Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        );
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
