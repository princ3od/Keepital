import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreProvider<E> {
  Future<E> fetch(dynamic id);
  Future<E> add(E obj);
  Future<E> update(dynamic id, E obj);
  Future<E> delete(dynamic id);
}
