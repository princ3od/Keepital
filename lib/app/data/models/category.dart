import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/enums/app_enums.dart';

class Category extends BaseModel {
  String iconId;
  String name;
  CategoryType type;
  bool isDebtNLoan;
  String parent;

  Category(String? id, {required this.iconId, required this.name, required this.type, required this.parent, required this.isDebtNLoan}) : super(id);

  Category.fromMap(Map<String, dynamic>? data)
      : name = data?['name'] ?? "",
        type = categoryFromString(data?['type']),
        iconId = data?['iconId'],
        parent = data?["parent"],
        isDebtNLoan = data?["isDebtNLoan"],
        super(data?['id']);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'iconId': iconId, 'name': name, 'type': type.str(), 'isDebtNLoan': isDebtNLoan, 'parent': parent};
  }
}
