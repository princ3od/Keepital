abstract class FirestoreProvider<T, E> {
  Future<E> fetch(T id);
  Future<E> add(E obj);
  Future<E> update(T id, E obj);
  Future<E> delete(T id);
}
