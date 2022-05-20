import 'package:flutter/material.dart';

import '../../home/domain/entities/product_entity.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
      ),
      backgroundColor: Colors.red.withOpacity(0.5),
      body: Center(child: Text(widget.product.toString())),
    );
  }
}
