import 'package:get/get.dart';
import 'package:keepital/app/modules/category/categories_controller.dart';

class CategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}
