import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day1/provider/products_op.dart';

import '../model/product.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;
  final Function(Product) onUpdate;

  AddProductPage({this.product, required this.onUpdate});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late int _price;
  late double _discountPercentage;
  late double _rating;
  late int _stock;
  late String _brand;
  late String _category;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _title = widget.product!.title;
      _description = widget.product!.description;
      _price = widget.product!.price;
      _discountPercentage = widget.product!.discountPercentage;
      _rating = widget.product!.rating;
      _stock = widget.product!.stock;
      _brand = widget.product!.brand;
      _category = widget.product!.category;
    } else {
      _title = '';
      _description = '';
      _price = 0;
      _discountPercentage = 0.0;
      _rating = 0.0;
      _stock = 0;
      _brand = '';
      _category = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Update Product' : 'Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  icon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  icon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(
                  labelText: 'Price',
                  icon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) => _price = int.parse(value!),
              ),
              TextFormField(
                initialValue: _discountPercentage.toString(),
                decoration: InputDecoration(
                  labelText: 'Discount Percentage',
                  icon: Icon(Icons.local_offer),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a discount percentage';
                  }
                  return null;
                },
                onSaved: (value) => _discountPercentage = double.parse(value!),
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(
                  labelText: 'Rating',
                  icon: Icon(Icons.star),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
                onSaved: (value) => _rating = double.parse(value!),
              ),
              TextFormField(
                initialValue: _stock.toString(),
                decoration: InputDecoration(
                  labelText: 'Stock',
                  icon: Icon(Icons.storage),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
                onSaved: (value) => _stock = int.parse(value!),
              ),
              TextFormField(
                initialValue: _brand,
                decoration: InputDecoration(
                  labelText: 'Brand',
                  icon: Icon(Icons.branding_watermark),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand';
                  }
                  return null;
                },
                onSaved: (value) => _brand = value!,
              ),
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(
                  labelText: 'Category',
                  icon: Icon(Icons.category),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) => _category = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final updatedProduct = Product(
                      title: _title,
                      description: _description,
                      price: _price,
                      discountPercentage: _discountPercentage,
                      rating: _rating,
                      stock: _stock,
                      brand: _brand,
                      category: _category,
                      id: 0,
                      images: [],
                      thumbnail: '',
                    );

                    if (widget.product != null) {
                      widget.onUpdate(updatedProduct);
                    } else {
                      Provider.of<ProductsOp>(context, listen: false)
                          .addProduct(updatedProduct);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(
                    widget.product != null ? 'Update Product' : 'Add Product'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
