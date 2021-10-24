import 'package:firebase_auth/firebase_auth.dart';
import 'package:keepital/app/data/models/base_model.dart';

class KeepitalUser with BaseModel {
  @override
  String? id;
  String? name;
  String? currencyId;
  late double amount;

  KeepitalUser(this.id, {this.name, this.currencyId, this.amount = 0});

  KeepitalUser.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    currencyId = data['currencyId'];
    amount = data['amount'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'currencyId': this.currencyId,
      'amount': this.amount,
    };
  }
}
