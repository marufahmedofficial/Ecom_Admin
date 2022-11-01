
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/category_model.dart';

class ProductProvider extends ChangeNotifier {
  Future<void> addNewCategory(String category) {
    final categoryModel = CategoryModel(categoryName: category);
    return DbHelper.addCategory(categoryModel);
  }

}