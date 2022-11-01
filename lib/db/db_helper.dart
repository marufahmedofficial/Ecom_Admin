import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class DbHelper {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection('Admins').doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel) {
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.categoryId = doc.id;
    return doc.set(categoryModel.toMap());
  }


}