import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/repeat_options.dart';

class RecurringTransaction extends BaseModel {
  num amount;
  late Category category;
  String currencyId;
  String? note;
  bool excludeFromReport;
  bool isMarkedFinished;
  String? walletId;

  RepeatOptions options;

  RecurringTransaction(String? id, {required this.amount, required this.category, required this.currencyId, this.note, this.excludeFromReport = false, this.walletId, required this.isMarkedFinished, required this.options}) : super(id);

  RecurringTransaction.fromMap(Map<String, dynamic> data)
      : amount = data['amount'],
        currencyId = data['currencyId'],
        note = data['note'],
        excludeFromReport = data['excludeFromReport'] ?? false,
        isMarkedFinished = data['isMarkedFinished'] ?? false,
        options = RepeatOptions.fromMap(data['options']),
        super(data['id']);

  @override
  Map<String, dynamic> toMap() {
    return {'amount': amount, 'category': category.id, 'currencyId': currencyId, 'note': note, 'excludeFromReport': excludeFromReport, 'isMarkedFinished': isMarkedFinished, 'options': options.toMap()};
  }
}
