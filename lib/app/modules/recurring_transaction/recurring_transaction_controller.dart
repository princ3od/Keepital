import 'package:get/get.dart';

class RecurringTransactionController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() async {
    isLoading = true;
    super.onInit();
    isLoading = false;
  }
}