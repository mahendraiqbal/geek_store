import 'package:commerce/pages/detailCart.dart';
import 'package:commerce/pages/detailItem.dart';
import 'package:commerce/services/entitiy/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commerce/provider/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  void _addToCartWithConfirmation(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Cart'),
          content: const Text(
              'Are you sure you want to add this product to the cart?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                addToCart(product);
              },
            ),
          ],
        );
      },
    );
  }

  void addToCart(Product product) {
    Provider.of<ProductProvider>(context, listen: false).addToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Store App'),
        backgroundColor: const Color(0xFFEA3A60),
      ),
      body: Column(
        // Wrap the entire body in a Column
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Fake Store', // Add a title under the AppBar
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            // Use Expanded to allow the GridView to take available space
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                final products = productProvider.products;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    // print(product);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Card(
                          color: const Color(0xFFFDF5F3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.only(top: 10),
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart),
                                onPressed: () =>
                                    _addToCartWithConfirmation(product),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        },
        label: const Text('Cart'),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: const Color(0xFFEA3A60),
      ),
    );
  }
}
