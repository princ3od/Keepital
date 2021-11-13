import 'package:get/get.dart';
import 'package:keepital/app/modules/add_category/add_category_controller.dart';

class AddCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryController>(() => AddCategoryController());
  }
}