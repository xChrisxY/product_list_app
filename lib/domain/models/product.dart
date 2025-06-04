class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price:
          (json['price'] is int)
              ? (json['price'] as int).toDouble()
              : json['price'] as double,
      category: json['category'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
