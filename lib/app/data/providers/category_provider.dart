import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/firestoration.dart';

class CategoryProvider implements Firestoration<String, Category> {
  @override
  Future<Category> add(Category obj) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  // TODO: implement collectionPath
  String get collectionPath => throw UnimplementedError();

  @override
  Future<Category> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Category> fetch(String id) async {
    final raw = await FirebaseFirestore.instance.collection(AppValue.categoryPath).doc(id).get();
    return Category.fromMap(raw.data());
  }

  @override
  Future<Category> update(String id, Category obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
