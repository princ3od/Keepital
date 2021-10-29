import 'package:keepital/app/data/models/base_model.dart';

class Wallet extends BaseModel {
  late String name;
  late num amount;
  late String currencyId;
  late String iconId;

  Wallet(String? id, {required this.name, required this.amount, required this.currencyId, required this.iconId}) : super(id);

  Wallet.fromMap(Map<String, dynamic> data) : super(data['id']) {
    name = data['name'];
    amount = data['amount'];
    currencyId = data['currencyId'];
    iconId = data['iconId'];
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
