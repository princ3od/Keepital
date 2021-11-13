import 'package:keepital/app/data/models/base_model.dart';

class Event extends BaseModel {
  String name;
  DateTime endDate;
  String currencyId;
  String currencySymbol;
  double spending;
  bool isMarkedCompleted;

  Event(
    String? id, {
    required this.name,
    required this.currencyId,
    required this.currencySymbol,
    required this.spending,
    required this.isMarkedCompleted,
    required this.endDate,
  }) : super(id);

  Event.fromMap(Map<String, dynamic> data)
      : name = data['name'] ?? '',
        endDate = DateTime.tryParse(data['endDate'].toDate().toString()) ?? DateTime.now(),
        spending = data['spending'] ?? 0,
        isMarkedCompleted = data['isMarkedCompleted'] ?? false,
        currencyId = data['currencyId'] ?? '',
        currencySymbol = data['currencySymbol'] ?? '',
        super(data['id']);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'endDate': endDate,
      'currency': currencyId,
      'spending': spending,
      'isMarkedCompleted': isMarkedCompleted,
    };
  }

  bool get isCompleted => isMarkedCompleted || endDate.isBefore(DateTime.now());
}
