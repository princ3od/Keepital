import 'package:keepital/app/data/models/base_model.dart';

class Wallet extends BaseModel {
  String name;
  num amount;
  String currencyId;
  String iconId;
  String currencySymbol;

  Wallet(String? id, {required this.name, required this.amount, required this.currencyId, required this.iconId, required this.currencySymbol}) : super(id);

  Wallet.fromMap(Map<String, dynamic> data)
      : name = data['name'],
        amount = data['amount'],
        currencyId = data['currencyId'],
        currencySymbol = data['currencySymbol'],
        iconId = data['iconId'],
        super(data['id']);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'amount': amount, 'currencyId': currencyId, 'iconId': iconId, 'currencySymbol': currencySymbol};
  }

  bool get isValid => (name.isNotEmpty && currencyId.isNotEmpty && iconId.isNotEmpty && currencySymbol.isNotEmpty);
}
