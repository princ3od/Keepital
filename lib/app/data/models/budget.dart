import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/data/models/category.dart';

class Budget extends BaseModel {
  Category? category;
  num amount;
  num spent;
  late String walletId;
  bool isFinished;
  DateTime beginDate;
  DateTime endDate;
  bool isRepeat;

  Budget(String? id, {this.category, required this.amount, required this.spent, required this.walletId, required this.isFinished, required this.beginDate, required this.endDate, required this.isRepeat}) : super(id);

  Budget.fromMap(Map<String, dynamic> data)
      : amount = data['amount'],
        spent = data['spent'],
        isFinished = data['isFinished'],
        beginDate = data['beginDate'].toDate(),
        endDate = data['endDate'].toDate(),
        isRepeat = data['isRepeat'],
        super(data['id']);

  @override
  Map<String, dynamic> toMap() {
    return {'category': category?.id ?? '', 'amount': amount, 'spent': spent, 'walletId': walletId, 'isFinished': isFinished, 'beginDate': beginDate, 'endDate': endDate, 'isRepeat': isRepeat};
  }
}
