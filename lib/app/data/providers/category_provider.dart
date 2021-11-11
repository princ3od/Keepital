import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/firestoration.dart';

class CategoryProvider implements Firestoration<String, Category> {
  @override
  Future<Category> add(Category obj) async {
    var categoriesColl = FirebaseFirestore.instance.collection(collectionPath);
    await categoriesColl.add(obj.toMap()).then((transRef) {
      obj.id = transRef.id;
      transRef.update({'id': transRef.id});
    });
    return obj;
  }

  @override
  String get collectionPath => AppValue.categoryPath;

  @override
  Future<Category> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Category> fetch(String id) async {
    final raw = await FirebaseFirestore.instance.collection(collectionPath).doc(id).get();
    return Category.fromMap(raw.data());
  }

  Future<List<Category>> fetchAll() async {
    List<Category> categories = [];
    final categoryCollection = await FirebaseFirestore.instance.collection(collectionPath).get();
    for (var categoryRaw in categoryCollection.docs) {
      var categoryRawData = categoryRaw.data();
      categoryRawData['id'] = categoryRaw.id;
      Category c = Category.fromMap(categoryRawData);
      categories.add(c);
    }
    return categories;
  }

  @override
  Future<Category> update(String id, Category obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
