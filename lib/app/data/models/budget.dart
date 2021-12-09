import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/global_widgets/wallet_button.dart';

class Budget extends BaseModel {
  Category category;
  num amount;
  num spent;
  String walletId;
  bool isFinished;
  DateTime beginDate;
  DateTime endDate;
  bool isRepeat;

  Budget(String? id, {required this.category, required this.amount, required this.spent, required this.walletId, required this.isFinished, required this.beginDate, required this.endDate, required this.isRepeat}) : super(id);

  Budget.fromMap(Map<String, dynamic> data)
      : category = data['category'],
        amount = data['amount'],
        spent = data['spent'],
        walletId = data['walletId'],
        isFinished = data['isFinished'],
        beginDate = data['beginDate'].toDate(),
        endDate = data['endDate'],
        isRepeat = data['isRepeat'],
        super(data['id']);

  @override
  Map<String, dynamic> toMap() {
    return {'category': category, 'amount': amount, 'spent': spent, 'walletId': walletId, 'isFinished': isFinished, 'beginDate': beginDate, 'endDate': endDate, 'isRepeat': isRepeat};
  }
}
