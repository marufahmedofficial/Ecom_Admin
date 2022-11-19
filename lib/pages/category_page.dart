import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../utils/widget_functions.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
              context: context,
              title: 'Category',
              positiveButtonText: 'ADD',
              onSubmit: (value) {
                Provider
                    .of<ProductProvider>(context, listen: false)
                    .addNewCategory(value);
              }
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Categories'),
      ),
    );
  }
}
