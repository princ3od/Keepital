import 'package:keepital/app/data/models/base_model.dart';

class Event extends BaseModel {
  late String name;
  late DateTime date;
  late String currency;
  late double spending;
  late bool isCompleted;

  Event(String? id, {required this.name, required this.currency, required this.spending, required this.isCompleted, required this.date}) : super(id);

  Event.fromMap(Map<String, dynamic> data) : super(data['id']) {
    name = data['name'];
    date = data['date'];
    spending = data['spending'] ?? 00;
    isCompleted = data['isCompleted'];
    currency = data['currency'];
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'date': date, 'currency': currency, 'spending': spending, 'isCompleted': isCompleted};
  }
}
