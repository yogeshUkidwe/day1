class Product {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    discountPercentage: json['discountPercentage'] as double,
    rating: json['rating'] as double,
    stock: json['stock'] as int,
    brand: json['brand'] as String,
    category: json['category'] as String,
    thumbnail: json['thumbnail'] as String,
    images: (json['images'] as List).cast<String>(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'brand': brand,
    'category': category,
    'thumbnail': thumbnail,
    'images': images,
  };
}
