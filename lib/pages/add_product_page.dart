import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  static const String routeName = '/addproduct';
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
    );
  }
}
