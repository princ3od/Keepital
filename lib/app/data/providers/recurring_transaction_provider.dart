import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/data/services/data_service.dart';

class RecurringTransactionProvider implements Firestoration<String, RecurringTransaction> {
  @override
  Future<RecurringTransaction> add(RecurringTransaction obj) async {
    final walletPath = _getUserPath.collection(AppValue.walletCollectionPath).doc(currentUser.currentWallet);
    final recurTransColl = walletPath.collection(collectionPath);

    await recurTransColl.add(obj.toMap()).then((transRef) {
      obj.id = transRef.id;
    });
    return obj;
  }

  @override
  String get collectionPath => AppValue.recurringTransactionPath;

  @override
  Future<String> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<RecurringTransaction> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  Future<List<RecurringTransaction>> fetchAll() async {
    List<RecurringTransaction> transactions = [];
    if (currentUser.currentWallet.isBlank ?? true) {
      for (var walletKey in currentUser.wallets.keys) {
        var transList = await fetchAllInWallet(walletKey);
        transactions.addAll(transList);
      }
    } else {
      var transList = await fetchAllInWallet(currentUser.currentWallet);
      transactions.addAll(transList);
    }

    return transactions;
  }

  Future<List<RecurringTransaction>> fetchAllInWallet(String walletId) async {
    List<RecurringTransaction> transactions = [];

    final walletPath = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final recurTransColl = await walletPath.collection(collectionPath).get();

    for (var rawTrans in recurTransColl.docs) {
      Map<String, dynamic> rawTransMap = rawTrans.data();

      rawTransMap['id'] = rawTrans.id;
      RecurringTransaction t = RecurringTransaction.fromMap(rawTransMap);
      t.category = await CategoryProvider().fetch(rawTransMap['category']);
      t.walletId = walletId;

      transactions.add(t);
    }
    return transactions;
  }

  @override
  Future<RecurringTransaction> update(String id, RecurringTransaction obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

  DocumentReference<Object?> get _getUserPath => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
  KeepitalUser get currentUser => DataService.currentUser!;
}
