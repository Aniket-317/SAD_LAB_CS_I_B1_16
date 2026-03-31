import 'dart:convert';

// Convert JSON string → List<Product>
List<Product> productFromMap(String str) {
  final data = json.decode(str);

  return List<Product>.from(
    data["products"].map((x) => Product.fromMap(x)),
  );
}

class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Convert JSON → Product object
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: (json["price"] is int)
            ? (json["price"] as int).toDouble()
            : json["price"],
        description: json["description"],
        category: json["category"],
        image: json["thumbnail"], // IMPORTANT (dummyjson uses thumbnail)
        rating: (json["rating"] is int)
            ? (json["rating"] as int).toDouble()
            : json["rating"],
      );
}