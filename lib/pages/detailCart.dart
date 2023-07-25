// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:commerce/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        final cartItems = productProvider.cartItems;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            backgroundColor: Colors.pink,
          ),
          body: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return ListTile(
                leading: Image.network(
                  cartItem.product.imageUrl,
                  width: 50,
                  height: 50,
                ),
                title: Text(cartItem.product.title),
                subtitle:
                    Text('\$${cartItem.product.price.toStringAsFixed(2)}'),
                trailing: Text('Quantity: ${cartItem.quantity}'),
              );
            },
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Price: \$${productProvider.getTotalPrice().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
