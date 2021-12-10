import 'package:get/get.dart';
import 'package:keepital/app/data/providers/budget_provider.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
import 'package:keepital/app/data/providers/recurring_transaction_provider.dart';
import 'package:keepital/app/data/services/app_start_service.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/modules/app_setting/setting_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    await SettingController().userAppSetting();
    await AppStartService.instance.initFirebase();
    await Future<void>.delayed(Duration(seconds: 3));
    _navigateNextScreen();
    super.onInit();
  }

  void _navigateNextScreen() {
    if (AuthService.instance.isLogined) {
      _loadDataAndNavigateToSuitableScreen();
    } else {
      Get.offAllNamed(Routes.auth);
    }
  }

  _loadDataAndNavigateToSuitableScreen() async {
    await DataService.instance.loadUserData();
    await DataService.instance.loadCategoryData();
    await RecurringTransactionProvider().executeAll();
    await BudgetProvider().closeOverDateBudgets();
    await ExchangeRate.fetchExchangeRate();
    if (DataService.currentUser!.hasAnyWallet) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.firstWallet);
    }
  }
}
