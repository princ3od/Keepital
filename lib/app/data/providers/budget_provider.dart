import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/utils/utils.dart';
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
    throw UnimplementedError();
  }

  Future<String> deleteInWallet(String id, String walletId) async {
    final budgetsRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId).collection(collectionPath);
    await budgetsRef.doc(id).delete();
    return id;
  }

  @override
  Future<Budget> fetch(String id) {
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
  Future<Budget> update(String id, Budget obj) async {
    var transRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(obj.walletId).collection(collectionPath).doc(id);
    transRef.update(obj.toMap());
    return obj;
  }

  Future updateBudgetSpent(String walletId, String categoryId, DateTime date, num diff) async {
    var walletRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(walletId);
    var budgets = await fetchAllInWallet(walletId);
    budgets.forEach((element) async {
      if ((element.category == null || element.category!.id == categoryId) && date.isBetweenDates(element.beginDate, element.endDate)) {
        var budgetRef = walletRef.collection(collectionPath).doc(element.id);
        budgetRef.update({'spent': element.spent + diff});
      }
    });
  }

  Future closeOverDateBudgets() async {
    for (var walletId in currentUser.wallets.keys) {
      closeOverDateBudgetsInWallet(walletId);
    }
  }

  Future closeOverDateBudgetsInWallet(String walletId) async {
    var now = DateTime.now();
    var budgets = await fetchAllInWallet(walletId);
    budgets.forEach((element) async {
      if (element.endDate.isStrictlyBeforeDate(now)) {
        closeBudget(element);
      }
    });
  }

  Future closeBudget(Budget budget) async {
    var budgetRef = _getUserPath.collection(AppValue.walletCollectionPath).doc(budget.walletId).collection(collectionPath).doc(budget.id);
    budgetRef.update({'isFinished': true});
  }

  DocumentReference<Object?> get _getUserPath => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
  KeepitalUser get currentUser => DataService.currentUser!;
}
