import 'package:get/get.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/providers/category_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/category/categories_controller.dart';

class AddCategoryController extends GetxController {
  late Rx<CategoryType> categoryType;
  var icon = Assets.inAppIconElectricityBill.path.obs;
  Category? parent;
  bool isDebtNLoan = false;
  RxString parentName = ''.obs;
  final CategoriesController categoryController = Get.find<CategoriesController>();
  RxBool isCatTypeDisable = true.obs;

  void onSave(String name) async {
    var category;
    if (parent == null) {
      category = Category('', iconId: icon.value, name: name, type: categoryType.value, parent: '', isDebtNLoan: isDebtNLoan);
    } else {
      category = Category('', iconId: icon.value, name: name, type: parent!.type, parent: parent!.id!, isDebtNLoan: parent!.isDebtNLoan);
    }
    category = await CategoryProvider().add(category);
    DataService.categories.add(category);
    await categoryController.refreshData();
  }
}
