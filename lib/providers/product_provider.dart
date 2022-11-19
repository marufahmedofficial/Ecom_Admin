
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/category_model.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  Future<void> addNewCategory(String category) {
    final categoryModel = CategoryModel(categoryName: category);
    return DbHelper.addCategory(categoryModel);
  }

  getAllCategories() {
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length, (index) =>
          CategoryModel.fromMap(snapshot.docs[index].data()));
      categoryList.sort((cat1, cat2) => cat1.categoryName.compareTo(cat2.categoryName));
      notifyListeners();
    });
  }
}