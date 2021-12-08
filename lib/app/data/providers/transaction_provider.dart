import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/data/services/data_service.dart';

class TransactionProvider implements Firestoration<String, TransactionModel> {
  @override
  Future<TransactionModel> add(TransactionModel obj) async {
    final userPath = _getUserPath;

    final walletPath = userPath.collection(AppValue.walletCollectionPath).doc(obj.walletId);
    final transColl = walletPath.collection(collectionPath);
    await transColl.add(obj.toMap()).then((transRef) {
      obj.id = transRef.id;
    });
    return obj;
  }

  Future<TransactionModel> addToWallet(TransactionModel obj, String walletId) async {
    final userPath = _getUserPath;

    final walletPath = userPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final transColl = walletPath.collection(collectionPath);
    await transColl.add(obj.toMap()).then((transRef) {
      obj.id = transRef.id;
    });
    return obj;
  }

  @override
  String get collectionPath => AppValue.transactionCollectionPath;

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
  Future<TransactionModel> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  Future<List<TransactionModel>> fetchAll() async {
    List<TransactionModel> transactions = [];
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

  Future<List<TransactionModel>> fetchAllInWallet(String walletId) async {
    List<TransactionModel> transactions = [];
    final userPath = _getUserPath;

    final walletPath = userPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final transColl = await walletPath.collection(collectionPath).get();
    for (var rawTrans in transColl.docs) {
      Map<String, dynamic> rawTransMap = rawTrans.data();
      rawTransMap['id'] = rawTrans.id;
      TransactionModel t = TransactionModel.fromMap(rawTransMap);
      t.category = await CategoryProvider().fetch(rawTransMap['category']);
      t.walletId = walletId;

      transactions.add(t);
    }
    return transactions;
  }

  @override
  Future<TransactionModel> update(String id, TransactionModel obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<TransactionModel> updateInWallet(String id, String walletId, TransactionModel obj) async {
    var transRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId).collection(collectionPath).doc(id);
    transRef.update(obj.toMap());
    obj.id = transRef.id;
    return obj;
  }

  DocumentReference<Object?> get _getUserPath => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
  KeepitalUser get currentUser => DataService.currentUser!;
}
