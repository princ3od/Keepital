import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/data/models/category.dart';

class TransactionModel extends BaseModel {
  num amount;
  late Category category;
  String? contact;
  String currencyId;
  DateTime date;
  String? eventId;
  num? extraAmountInfo;
  String? note;

  TransactionModel(String? id, {required this.amount, required this.category, this.contact, required this.currencyId, required this.date, this.eventId, this.extraAmountInfo, this.note}) : super(id);

  TransactionModel.fromMap(Map<String, dynamic> data)
      : amount = data['amount'],
        contact = data['contact'],
        currencyId = data['currencyId'],
        date = DateTime.tryParse(data['date'].toDate().toString())!,
        eventId = data['eventId'],
        extraAmountInfo = data['extraAmountInfo'],
        note = data['note'],
        super(data['id']);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'amount': amount, 'category': category.id, 'contact': contact, 'currencyId': currencyId, 'date': date, 'eventId': eventId, 'extraAmountInfo': extraAmountInfo, 'note': note};
  }
}
