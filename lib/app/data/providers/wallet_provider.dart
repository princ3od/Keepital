import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/firestoration.dart';
import 'package:keepital/app/data/services/auth_service.dart';

class WalletProvider implements Firestoration<String, Wallet> {
  @override
  String get collectionPath => AppValue.walletCollectionPath;

  @override
  Future<Wallet> add(Wallet obj) async {
    final userPath = _getUserPath();
    final userWalletCollectionReference = userPath.collection(AppValue.walletCollectionPath);
    await userWalletCollectionReference.add(obj.toMap()).then((walletReference) {
      obj.id = walletReference.id;
    });
    return obj;
  }

  @override
  Future<Wallet> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Wallet> fetch(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Wallet> update(String id, Wallet obj) async {
    final userPath = _getUserPath();
    await userPath.collection(AppValue.walletCollectionPath).doc(id).update(obj.toMap());
    return obj;
  }

  Future<Map<String, Wallet>> fetchAll() async {
    Map<String, Wallet> wallets = {};
    final userPath = _getUserPath();
    final userWalletCollection = await userPath.collection(AppValue.walletCollectionPath).get();
    for (var rawWallet in userWalletCollection.docs) {
      Map<String, dynamic> rawWalletMap = rawWallet.data();
      rawWalletMap['id'] = rawWallet.id;
      Wallet w = Wallet.fromMap(rawWalletMap);
      wallets[rawWallet.id] = w;
    }
    return wallets;
  }

  DocumentReference<Object?> _getUserPath() => FirebaseFirestore.instance.collection(AppValue.userCollectionPath).doc(AuthService.instance.currentUser!.uid);
}
