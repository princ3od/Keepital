import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/services/data_service.dart';

var formatter = new DateFormat('dd MMMM yyyy');

class AddTransactionController extends GetxController {  
  var wallets = DataService.currentUser!.wallets;
  var currentWallet = DataService.currentUser!.currentWallet.obs;
  late var curWalletName = (wallets[currentWallet]?.name ?? '').obs;
  late var curWalletAmount = (wallets[currentWallet]?.amount.toString() ?? '').obs;

  var categories = DataService.categories;
  RxInt selectedIndex = (-1).obs;

  RxNum amount = RxNum(0);
  Category? category;
  late var strCategory = ''.tr.obs; 
  RxString note = ''.obs;
  var date = DateTime.now();
  late var strDate = formatter.format(date).obs;
  var wallet = DataService.currentUser!.wallets[DataService.currentUser!.currentWallet];

  RxBool excludeFromReport = false.obs;

  String oldWalletId = '';
}
