import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_strings.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/providers/firestoration.dart';

class UserProvider implements Firestoration<String, KeepitalUser> {
  @override
  String get collectionPath => AppValue.userCollectionPath;

  @override
  Future<KeepitalUser> add(KeepitalUser obj) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(obj.id).set(obj.toMap());
    return obj;
  }

  @override
  Future<KeepitalUser> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<KeepitalUser> fetch(String id) async {
    final raw = await FirebaseFirestore.instance.collection(collectionPath).doc(id).get();
    return KeepitalUser.fromMap(raw.data());
  }

  @override
  Future<KeepitalUser> update(String id, KeepitalUser obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<bool> isExists(String id) async {
    var doc = await FirebaseFirestore.instance.collection(collectionPath).doc(id).get();
    return doc.exists;
  }
}
