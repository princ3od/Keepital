import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/budget.dart';
import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/data/services/data_service.dart';

class BudgetProvider implements Firestoration<String, Budget> {
  @override
  Future<Budget> add(Budget obj) async {
    final walletPath = _getUserPath.collection(AppValue.walletCollectionPath).doc(obj.walletId);
    final budgetColl = walletPath.collection(collectionPath);

    await budgetColl.add(obj.toMap()).then((budgetRef) {
      obj.id = budgetRef.id;
    });
    return obj;
  }

  @override
  String get collectionPath => AppValue.budgetCollectionPath;

  @override
  Future<String> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Budget> fetch(String id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  Future<List<Budget>> fetchAll() async {
    List<Budget> budgets = [];
    for (var walletKey in currentUser.wallets.keys) {
      var transList = await fetchAllInWallet(walletKey);
      budgets.addAll(transList);
    }

    return budgets;
  }

  Future<List<Budget>> fetchAllInWallet(String walletId) async {
    List<Budget> budgets = [];

    final walletPath = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId);
    final budgetColl = await walletPath.collection(collectionPath).get();
    for (var rawBudget in budgetColl.docs) {
      Map<String, dynamic> rawBudgetMap = rawBudget.data();
      rawBudgetMap['id'] = rawBudget.id;
      Budget b = Budget.fromMap(rawBudgetMap);
      if (rawBudgetMap['category'].isNotEmpty) {
        b.category = await CategoryProvider().fetch(rawBudgetMap['category']);
      }
      b.walletId = walletId;

      budgets.add(b);
    }
    return budgets;
  }

  @override
  Future<Budget> update(String id, Budget obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

  DocumentReference<Object?> get _getUserPath => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
  KeepitalUser get currentUser => DataService.currentUser!;
}
