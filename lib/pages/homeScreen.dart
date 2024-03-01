import 'dart:async';

import 'package:day1/provider/products_op.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/defaultPadding.dart';
import '../widget/productCard.dart';
import '../widget/productSearchDelegate.dart';
import 'addProduct.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedCategoryId = -1;
  bool isDesktop=false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isDesktop = MediaQuery.of(context).size.width >= 640;
    return Scaffold(
      appBar: AppBar(
          title: Text("VKart",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber.shade200,
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => _buildFilterBottomSheet(context),
              ),
              icon: const Icon(Icons.filter_alt_rounded),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegate(
                    products: Provider.of<ProductsOp>(context, listen: false)
                        .allProducts,
                    onSearch: (searchTerm) => setState(() {
                      // _searchText = searchTerm;
                    }),
                  ),
                );
              },
            ),
          ]),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.amber.shade400,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProductPage(
                      onUpdate: (Product) {},
                    )), // Navigate to AddProductPage
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          // Add comments to explain the purpose of fetching data
          future: Provider.of<ProductsOp>(context, listen: false)
              .fetchProducts(0, 11),
          builder: (context, dataSnapshot) {
            final filteredProducts =
                Provider.of<ProductsOp>(context, listen: false).allProducts;

            if (Provider.of<ProductsOp>(context, listen: false).sortByPrice) {
              filteredProducts.sort((a, b) => a.price.compareTo(b.price));
            }
            if (Provider.of<ProductsOp>(context, listen: false).sortRating) {
              filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
            }
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(child: Text('An error occurred'));
              } else {
                if(isDesktop) {
                 return ListView.builder(
                   itemCount: Provider
                       .of<ProductsOp>(context, listen: false)
                       .allProducts
                       .length,
                   itemBuilder: (context, index) {
                     final product =
                     Provider
                         .of<ProductsOp>(context, listen: false)
                         .allProducts[index];
                     return Column(
                       children: [
                         ProductCard(product: product),
                       ],
                     );
                   },
                 );

                }
                else{
                  return ListView.builder(
                    itemCount: Provider
                        .of<ProductsOp>(context, listen: false)
                        .allProducts
                        .length,
                    itemBuilder: (context, index) {
                      final product =
                      Provider
                          .of<ProductsOp>(context, listen: false)
                          .allProducts[index];
                      return Column(
                        children: [
                          ProductCard(product: product),
                        ],
                      );
                    },
                  );
                }
              }
            }
          }),
    );
  }

  Widget _buildFilterBottomSheet(BuildContext context) {
    return Consumer<ProductsOp>(builder: (context, person, child) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Sort by Price'),
              value:
                  Provider.of<ProductsOp>(context, listen: false).sortByPrice,
              onChanged: (value) => setState(() =>
                  Provider.of<ProductsOp>(context, listen: false)
                      .toggleSortByPrice()),
            ),
            CheckboxListTile(
              title: const Text('Sort by Stock'),
              value: Provider.of<ProductsOp>(context, listen: false)
                  .showInStockOnly,
              onChanged: (value) => setState(() =>
                  Provider.of<ProductsOp>(context, listen: false)
                      .toggleShowInStockOnly()),
            ),
            CheckboxListTile(
              title: const Text('Sort by Rating'),
              value: Provider.of<ProductsOp>(context, listen: false)
                  .sortRating,
              onChanged: (value) => setState(() =>
                  Provider.of<ProductsOp>(context, listen: false)
                      .toggleSortByRating()),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      );
    });
  }
}
