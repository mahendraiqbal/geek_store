import 'package:commerce/services/interface/api_clients.dart';
import 'package:flutter/foundation.dart';
import 'package:commerce/services/entitiy/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  final List<CartItem> _cartItems = [];

  List<Product> get products => _products;
  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    var cartItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (cartItem.quantity == 0) {
      _cartItems.add(CartItem(product: product, quantity: 1));
    } else {
      cartItem.quantity++;
    }

    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var cartItem in _cartItems) {
      total += cartItem.product.price * cartItem.quantity;
    }
    return total;
  }

  Future<void> fetchProducts() async {
    try {
      final productService = ProductService();
      final products = await productService.fetchProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
