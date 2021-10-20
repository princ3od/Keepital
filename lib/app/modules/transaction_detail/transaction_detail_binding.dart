import 'package:get/get.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_controller.dart';
import 'package:keepital/app/modules/transaction_detail/screens/transaction_detail_screen.dart';
import 'package:keepital/app/modules/transaction_detail/transaction_detail_controller.dart';


class TransactionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailController>(() => TransactionDetailController());
  }
}