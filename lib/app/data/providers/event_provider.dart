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
    final result = await userCollectionReference.collection(collectionPath).add(obj.toMap());
    obj.id = result.id;
    return obj;
  }

  @override
  Future<String> delete(String id) async {
    await userCollectionReference.collection(collectionPath).doc(id).delete();
    return id;
  }

  @override
  Future<Event> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<Event> update(String id, Event obj) async {
    await userCollectionReference.collection(collectionPath).doc(id).update(obj.toMap());
    return obj;
  }

  Future<List<Event>> fetchAll() async {
    List<Event> events = [];
    final raw = await userCollectionReference.collection(collectionPath).orderBy('endDate').get();
    for (var item in raw.docs) {
      events.add(Event.fromMap(item.id, item.data()));
    }
    return events;
  }

  get currentUserId => DataService.currentUser!.id;
  DocumentReference get userCollectionReference => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(currentUserId);
}
