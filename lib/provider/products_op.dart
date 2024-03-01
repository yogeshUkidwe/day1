import 'dart:convert';

import 'package:day1/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

import '../model/category.dart';

class ProductsOp with ChangeNotifier {
  List<Product> allProducts = [];
  List<Product> cart = [];
  List<Category> categoryList = [];
  bool sortByPrice = false;
  bool sortRating = false;
  bool showInStockOnly = false;
  String productDetail="";
  static const String baseUrl = "https://dummyjson.com/products/add";

  void toggleSortByPrice() {
    sortByPrice = !sortByPrice;
    notifyListeners();
  }

  void toggleSortByRating() {
    sortRating = !sortRating;
    notifyListeners();
  }

  void toggleShowInStockOnly() {
    showInStockOnly = !showInStockOnly;
    notifyListeners();
  }

  Future<List<Product>> fetchProducts(int page, int limit) async {
    final url = Uri.parse(
        'https://dummyjson.com/products?skip=${page * limit}&limit=$limit');
    final response = await get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final products = (data['products'] as List).map((item) {
        return Product.fromJson(item);
      }).toList();
      allProducts = products;
      return products;
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }

  // CRUD Operations
  Future<void> addProduct(Product product) async {
    var url = Uri.parse(baseUrl);
    var body = jsonEncode(product.toJson());
    var headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("Product added successfully");
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception while adding product: $e");
    }
  }

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse(
        'https://dummyjson.com/products/categories'); // Replace with your API endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch categories: ${response.statusCode}');
    }
  }

  Future<void> updateProductById(Product updatedProduct) async {
    final url = Uri.https('dummyjson.com', '/products/${updatedProduct.id}');

    try {
      final response = await http.put(
        url,
        body: {
          'title': updatedProduct.title,
          'description': updatedProduct.description,
          'price': updatedProduct.price.toString(),
          'discountPercentage': updatedProduct.discountPercentage.toString(),
          'rating': updatedProduct.rating.toString(),
          'stock': updatedProduct.stock.toString(),
          'brand': updatedProduct.brand,
          'category': updatedProduct.category,
          // Add other fields as needed
        },
      );

      if (response.statusCode == 200) {
        // Product updated successfully
        // You can update the local data or notify listeners here
        print('Product updated successfully');
      } else {
        // Handle other status codes if needed
        print('Failed to update product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors during the HTTP request
      print('Error updating product: $error');
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < allProducts.length) {
      allProducts.removeAt(index);
      notifyListeners();
    }
  }

//  Cart Operation
  void addToCart(Product product) {
    // Access your Cart instance (replace with your specific logic)

    // Check if the product already exists in the cart
    if (!cart.contains(product)) {
      // Add the product to the cart
      cart.add(product);
    } else {
      // Optionally, handle the case where the product is already in the cart
      // (e.g., display a message or update the quantity)
      print('Product ${product.id} already exists in the cart!');
    }

    // Update the UI accordingly (e.g., show a confirmation message or update the cart badge)
  }

  // AI Implementation

  Future<String> getResult(String searchText, String context) async {

    return "";
  }
}
