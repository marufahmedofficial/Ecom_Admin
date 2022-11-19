import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../providers/product_provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/viewproduct';
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  CategoryModel? categoryModel;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return provider.productList.isEmpty ?
          const Center(child: Text('No product found'),) :
          Column(
            children: [
              Consumer<ProductProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<CategoryModel>(
                      hint: const Text('Select Category'),
                      value: categoryModel,
                      isExpanded: true,
                      validator: (value) {
                        if(value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      items: provider.getCategoryListForFiltering().map((catModel) =>
                          DropdownMenuItem(
                              value: catModel,
                              child: Text(catModel.categoryName))).toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryModel = value;
                        });
                        provider.getAllProductsByCategory(categoryModel!);
                      },
                    ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    final product = provider.productList[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                        width: 75,
                        imageUrl: product.thumbnailImageUrl,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: Text(product.productName),
                      subtitle: Text(product.category.categoryName),
                      trailing: Text('Stock: ${product.stock}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}