import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:keepital/app/core/utils/utils.dart';
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

  Future<RecurringTransaction> addToWallet(RecurringTransaction obj, String walletId) async {
    final walletPath = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final recurTransColl = walletPath.collection(collectionPath);

    await recurTransColl.add(obj.toMap()).then((transRef) {
      obj.id = transRef.id;
    });
    return obj;
  }

  @override
  String get collectionPath => AppValue.recurringTransactionPath;

  @override
  Future<String> delete(String id) async {
    final transRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(DataService.currentWallet.value.id).collection(collectionPath);
    await transRef.doc(id).delete();
    return id;
  }

  Future<String> deleteInWallet(String id, String walletId) async {
    final transRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId).collection(collectionPath);
    await transRef.doc(id).delete();
    return id;
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

  Future<List<RecurringTransaction>> fetchAllUnfinished() async {
    List<RecurringTransaction> transactions = [];
    for (var walletKey in currentUser.wallets.keys) {
      var transList = await fetchUnfinishedInWallet(walletKey);
      transactions.addAll(transList);
    }
    return transactions;
  }

  Future<List<RecurringTransaction>> fetchUnfinishedInWallet(String walletId) async {
    List<RecurringTransaction> transactions = [];

    final walletPath = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final recurTransColl = await walletPath.collection(collectionPath).where('isMarkedFinished', isEqualTo: false).get();

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
  Future<RecurringTransaction> update(String id, RecurringTransaction obj) async {
    var transRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(obj.walletId).collection(collectionPath).doc(id);
    transRef.update(obj.toMap());
    return obj;
  }

  Future execute(RecurringTransaction transaction) async {
    switch (transaction.options.id) {
      case 0:
        await _executeForeverRecurringTrans(transaction);
        return;
      case 1:
        await _executeRangedRecurringTrans(transaction);
        return;
      case 2:
        await _executeCountedRecurringTrans(transaction);
        return;
    }
  }

  Future _executeForeverRecurringTrans(RecurringTransaction transaction) async {
    var now = DateTime.now();
    for (var iter = transaction.options.nextOcurrence(); iter.isBeforeDate(now); iter = transaction.options.nextOcurrence()) {
      transaction.options.startDate = iter;

      await DataService.addTransaction(transaction.toTransactionModel());
    }
    await RecurringTransactionProvider().update(transaction.id!, transaction);
  }

  Future _executeRangedRecurringTrans(RecurringTransaction transaction) async {
    var now = DateTime.now();
    for (var iter = transaction.options.nextOcurrence(); iter.isBeforeDate(now) && iter.isBeforeDate(transaction.options.endDate!); iter = transaction.options.nextOcurrence()) {
      transaction.options.startDate = iter;

      await DataService.addTransaction(transaction.toTransactionModel());
    }

    if (transaction.options.nextOcurrence().isStrictlyAfterDate(transaction.options.endDate!)) {
      transaction.isMarkedFinished = true;
    }
    await RecurringTransactionProvider().update(transaction.id!, transaction);
  }

  Future _executeCountedRecurringTrans(RecurringTransaction transaction) async {
    var now = DateTime.now();
    for (var iter = transaction.options.nextOcurrence(); iter.isBeforeDate(now) && transaction.options.count < transaction.options.numRepetition!; iter = transaction.options.nextOcurrence()) {
      transaction.options.startDate = iter;
      transaction.options.count++;

      await DataService.addTransaction(transaction.toTransactionModel());
    }

    if (transaction.options.count >= transaction.options.numRepetition!) {
      transaction.isMarkedFinished = true;
    }
    await RecurringTransactionProvider().update(transaction.id!, transaction);
  }

  Future executeAll() async {
    var transList = await fetchAllUnfinished();
    transList.forEach((element) async {
      await execute(element);
    });
  }

  DocumentReference<Object?> get _getUserPath => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
  KeepitalUser get currentUser => DataService.currentUser!;
}
