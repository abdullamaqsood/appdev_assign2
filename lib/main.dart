import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdev_assign2/products/api/products_provider.dart';
import 'package:appdev_assign2/products/api/products_model.dart';
import 'package:appdev_assign2/products/widgets/category_buttons.dart';
import 'package:appdev_assign2/products/widgets/product_card.dart';
import 'package:appdev_assign2/products/widgets/loader_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsScreen(),
      ),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final productList = productProvider.products;

    List<ProductModel> filteredProducts = selectedCategory == "All"
        ? productList
        : productList.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          CategoryButtons(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });

              productProvider.setLoading(true);

              Future.delayed(const Duration(milliseconds: 500), () {
                productProvider.setLoading(false);
              });
            },
          ),
          Expanded(
            child: productProvider.isLoading
                ? const ShimmerGrid()
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
