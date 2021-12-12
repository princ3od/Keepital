import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/data/models/wallet.dart';

class KeepitalUser extends BaseModel {
  String name;
  String currencyId;
  String currencySymbol;
  num amount;
  String currentWallet;
  Map<String, Wallet> wallets = {};

  KeepitalUser(String id, {required this.name, required this.currencyId, required this.currencySymbol, this.amount = 0, this.currentWallet = ''}) : super(id);

  KeepitalUser.fromMap(Map<String, dynamic>? data)
      : name = data?['name'] ?? '',
        currencyId = data?['currencyId'] ?? '',
        currencySymbol = data?['currencySymbol'] ?? '',
        amount = data?['amount'] ?? 0,
        currentWallet = data?['currentWallet'] ?? '',
        super(data?['id'] ?? '');

  @override
  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'currencyId': this.currencyId, 'currencySymbol': this.currencySymbol, 'amount': this.amount, 'currentWallet': this.currentWallet};
  }

  bool get hasAnyWallet => wallets.isNotEmpty;
  bool get iscurrentWalletEmpty => currentWallet == '';
}
