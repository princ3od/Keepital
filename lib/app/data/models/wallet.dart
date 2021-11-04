import 'package:keepital/app/data/models/base_model.dart';

class Wallet extends BaseModel {
  late String name;
  late num amount;
  late String currencyId;
  late String iconId;
  late String currencySymbol;

  Wallet(String? id, {required this.name, required this.amount, required this.currencyId, required this.iconId, required this.currencySymbol}) : super(id);

  Wallet.fromMap(Map<String, dynamic> data) : super(data['id']) {
    name = data['name'];
    amount = data['amount'];
    currencyId = data['currencyId'];
    currencySymbol = data['currencySymbol'];
    iconId = data['iconId'];
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'amount': amount, 'currencyId': currencyId, 'iconId': iconId, 'currencySymbol': currencySymbol};
  }

  bool checkIsValidInputDataToAdd() {
    if (name == "" || currencyId == "" || iconId == "" || currencySymbol == "") {
      return false;
    }
    return true;
  }
}
