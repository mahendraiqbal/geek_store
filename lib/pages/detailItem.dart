import 'package:flutter/material.dart';
import 'package:commerce/services/entitiy/product.dart';
import 'package:provider/provider.dart';
import 'package:commerce/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  void _addToCartWithConfirmation(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Cart'),
          content: const Text(
              'Are you sure you want to add this product to the cart?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.pink),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.pink),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                addToCart(context, product);
              },
            ),
          ],
        );
      },
    );
  }

  void addToCart(BuildContext context, Product product) {
    Provider.of<ProductProvider>(context, listen: false).addToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 3,
                  right: 3,
                  child: Card(
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () =>
                          _addToCartWithConfirmation(context, product),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
