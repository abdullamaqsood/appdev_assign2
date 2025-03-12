import 'package:flutter/material.dart';

class CategoryButtons extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryButtons({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    const categoryList = [
      "All",
      "electronics",
      "jewelery",
      "men's clothing",
      "women's clothing"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryList.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (isSelected) {
                if (isSelected && category != selectedCategory) {
                  onCategorySelected(category);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
