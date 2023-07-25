// product.dart
class Product {
  int id;
  String title;
  double price;
  final String imageUrl;
  String description;
  // Rating rating;
  // Other product details as required

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    // required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      imageUrl: json['image'],
      description: json['description'],
      // rating: Rating(
      //   rate: json['rating']['rate'],
      //   count: json['rating']['count'],
      // ),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});
}

// cart_item.dart
class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
