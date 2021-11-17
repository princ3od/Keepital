import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/data_service.dart';

class EventProvider implements Firestoration<String, Event> {
  @override
  String get collectionPath => AppValue.eventCollectionPath;

  @override
  Future<Event> add(Event obj) async {
    await userCollectionReference.collection(collectionPath).add(obj.toMap());
    return obj;
  }

  @override
  Future<Event> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Event> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<Event> update(String id, Event obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

  get currentUserId => DataService.currentUser!.id;
  DocumentReference get userCollectionReference => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(currentUserId);
}
