import 'package:flutter/material.dart';

import '../model/product.dart';
import '../pages/productDetailScreen.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ProductSearchDelegate(
      {required this.products,
      required void Function(dynamic searchTerm) onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.thumbnail),
          ),
          title: Text(product.title),
          subtitle: Text(
            "in ${product.category}",
            style: TextStyle(color: Colors.blue),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredProducts = query.isEmpty
        ? products
        : products
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.thumbnail),
          ),
          title: Text(product.title),
        subtitle: Text(
        "in ${product.category}",
        style: TextStyle(color: Colors.blue),),
          onTap: () {
            query = product.title;
            showResults(context);
          },
        );
      },
    );
  }
}
