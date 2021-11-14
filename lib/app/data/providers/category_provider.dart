import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/data_service.dart';

class CategoryProvider implements Firestoration<String, Category> {
  @override
  Future<Category> add(Category obj) async {
    var categoriesColl = userCollectionRef.collection(collectionPath);
    await categoriesColl.add(obj.toMap()).then((cateRef) {
      obj.id = cateRef.id;
      cateRef.update({'id': cateRef.id});
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
    final raw = await userCollectionRef.collection(collectionPath).doc(id).get();
    return Category.fromMap(raw.data());
  }

  Future<List<Category>> conditionalFetch(String parent) async {
    List<Category> categories = [];

    final categoriesRaw = await userCollectionRef.collection(collectionPath).where('parent', isEqualTo: parent).get();
    for (var categoryRaw in categoriesRaw.docs) {
      var cateRawData = categoryRaw.data();
      Category c = Category.fromMap(cateRawData);
      categories.add(c);
    }
    return categories;
  }

  Future<List<Category>> fetchAll() async {
    List<Category> categories = [];
    final categoryCollection = await userCollectionRef.collection(collectionPath).get();
    for (var categoryRaw in categoryCollection.docs) {
      var categoryRawData = categoryRaw.data();
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

  Future<List<Category>> fetchAllPublic() async {
    List<Category> categories = [];
    final categoryCollection = await FirebaseFirestore.instance.collection(collectionPath).get();
    for (var categoryRaw in categoryCollection.docs) {
      var categoryRawData = categoryRaw.data();
      Category c = Category.fromMap(categoryRawData);
      categories.add(c);
    }
    return categories;
  }

  Future makeACopy2CurUser() async {
    var categories = await fetchAllPublic();

    final userColl = FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(curUserId);
    for (var category in categories) {
      userColl.collection(AppValue.categoryPath).add(category.toMap()).then((cateRef) {
        cateRef.update({'id': cateRef.id});
      });
    }
  }

  String get curUserId => DataService.currentUser!.id!;
  get userCollectionRef => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(curUserId);
}
