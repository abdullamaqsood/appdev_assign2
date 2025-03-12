import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 18);
        } else if (hasHalfStar && index == fullStars) {
          return Stack(
            children: [
              Icon(Icons.star, color: Colors.grey[500], size: 18),
              ClipRect(
                clipper: _HalfStarClipper(),
                child: const Icon(Icons.star, color: Colors.amber, size: 18),
              ),
            ],
          );
        } else {
          return Icon(Icons.star, color: Colors.grey[500], size: 18);
        }
      }),
    );
  }
}

class _HalfStarClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
