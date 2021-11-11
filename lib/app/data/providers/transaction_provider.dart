import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/data/services/data_service.dart';

class TransactionProvider implements Firestoration<String, TransactionModel> {
  final currentUser = DataService.currentUser!;

  @override
  Future<TransactionModel> add(TransactionModel obj) async {
    final userPath = _getUserPath();

    final walletPath = userPath.collection(AppValue.walletCollectionPath).doc(currentUser.currentWallet);
    final transColl = walletPath.collection(collectionPath);
    await transColl.add(obj.toMap()).then((transRef) {
      obj.id = transRef.id;
    });
    return obj;
  }

  Future<TransactionModel> addToWallet(TransactionModel obj, String walletId) async {
    final userPath = _getUserPath();

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
  Future<TransactionModel> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
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
    final userPath = _getUserPath();

    final walletPath = userPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final transColl = await walletPath.collection(collectionPath).get();
    for (var rawTrans in transColl.docs) {
      Map<String, dynamic> rawTransMap = rawTrans.data();
      rawTransMap['id'] = rawTrans.id;
      TransactionModel t = TransactionModel.fromMap(rawTransMap);
      t.category = await CategoryProvider().fetch(rawTransMap['category']);
      transactions.add(t);
    }
    return transactions;
  }

  @override
  Future<TransactionModel> update(String id, TransactionModel obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

  DocumentReference<Object?> _getUserPath() => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
}
