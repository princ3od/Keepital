import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/base_model.dart';

class Event extends BaseModel {
  String name;
  DateTime? endDate;
  String currencyId;
  String currencySymbol;
  String currencyName;
  String iconId = Assets.inAppIconEducation.path;
  double spending;
  bool isMarkedFinished;

  Event(
    String? id, {
    required this.name,
    required this.currencyId,
    required this.currencySymbol,
    required this.currencyName,
    required this.spending,
    required this.isMarkedFinished,
    this.endDate,
  }) : super(id);

  Event.fromMap(String id, Map<String, dynamic> data)
      : name = data['name'] ?? '',
        endDate = DateTime.tryParse(data['endDate'].toDate().toString()) ?? DateTime.now(),
        spending = data['spending'] ?? 0,
        isMarkedFinished = data['isMarkedFinished'] ?? false,
        currencyId = data['currencyId'] ?? '',
        currencySymbol = data['currencySymbol'] ?? '',
        currencyName = data['currencyName'] ?? '',
        iconId = data['iconId'] ?? Assets.inAppIconEducation.path,
        super(id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'endDate': endDate,
      'currencyId': currencyId,
      'currencySymbol': currencySymbol,
      'currencyName': currencyName,
      'iconId': iconId,
      'spending': spending,
      'isMarkedFinished': isMarkedFinished,
    };
  }

  bool get isFinished => isMarkedFinished || endDate!.isBefore(DateTime.now());
  bool get isNotFinished => !isMarkedFinished || !endDate!.isBefore(DateTime.now());
}
