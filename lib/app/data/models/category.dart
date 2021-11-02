import 'package:keepital/app/data/models/base_model.dart';

class Category extends BaseModel {
  String iconId;
  String name;
  String type;

  Category(String? id, {required this.iconId, required this.name, required this.type}) : super(id);

  Category.fromMap(Map<String, dynamic>? data)
      : name = data?['name'],
        type = data?['type'],
        iconId = data?['iconId'],
        super(data?['id']);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'iconId': iconId, 'name': name, 'type': type};
  }
}
