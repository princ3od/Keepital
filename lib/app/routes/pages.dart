import 'package:get/get.dart';
import 'package:keepital/app/global_widgets/add_peoples.dart';
import 'package:keepital/app/global_widgets/amount_keyboard.dart';
import 'package:keepital/app/global_widgets/icon_selection_screen.dart';
import 'package:keepital/app/modules/about/about_page.dart';
import 'package:keepital/app/modules/add_category/add_category_binding.dart';
import 'package:keepital/app/modules/add_category/screens/add_category_screen.dart';
import 'package:keepital/app/modules/add_transaction/add_transaction_binding.dart';
import 'package:keepital/app/modules/add_wallet/add_wallet_binding.dart';
import 'package:keepital/app/modules/add_wallet/first_wallet_binding.dart';
import 'package:keepital/app/modules/add_wallet/screen/add_wallet_screen.dart';
import 'package:keepital/app/modules/app_setting/screen/setting_screen.dart';
import 'package:keepital/app/modules/app_setting/setting_binding.dart';
import 'package:keepital/app/modules/auth/auth_binding.dart';
import 'package:keepital/app/modules/auth/screens/auth_screen.dart';
import 'package:keepital/app/modules/budget/budget_binding.dart';
import 'package:keepital/app/modules/budget/screens/add_budget_screen.dart';
import 'package:keepital/app/modules/budget/screens/budget_detail_screen.dart';
import 'package:keepital/app/modules/budget/screens/budget_screen.dart';
import 'package:keepital/app/modules/budget/screens/select_time_range.dart';
import 'package:keepital/app/modules/category/categories_binding.dart';
import 'package:keepital/app/modules/category/screens/categories_screen.dart';
import 'package:keepital/app/modules/event/event_binding.dart';
import 'package:keepital/app/modules/event/screens/add_event_screen.dart';
import 'package:keepital/app/modules/event/screens/event_screen.dart';
import 'package:keepital/app/modules/add_wallet/screen/first_wallet_screen.dart';
import 'package:keepital/app/modules/home/home_binding.dart';
import 'package:keepital/app/modules/home/screens/home_screen.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_binding.dart';
import 'package:keepital/app/modules/my_wallets/screen/my_wallet_screen.dart';
import 'package:keepital/app/modules/recurring_transaction/recurring_transaction_binding.dart';
import 'package:keepital/app/modules/recurring_transaction/screens/recurring_transaction_screen.dart';
import 'package:keepital/app/modules/splash/screens/splash_screen.dart';
import 'package:keepital/app/modules/splash/splash_binding.dart';
import 'package:keepital/app/modules/transaction_detail/screens/transaction_detail_screen.dart';
import 'package:keepital/app/modules/transaction_detail/transaction_detail_binding.dart';
import 'package:keepital/app/modules/wallet_balance/screens/wallet_balance_screen.dart';
import 'package:keepital/app/modules/wallet_balance/wallet_balance_binding.dart';
import 'package:keepital/app/modules/add_transaction/screens/add_transaction_screen.dart';

part './routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.auth,
      page: () => AuthenticationScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.firstWallet,
      page: () => FirstWalletScreen(),
      binding: FirstWalletScreenBinding(),
    ),
    GetPage(
      name: Routes.transactionDetail,
      page: () => TransactionDetailScreen(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: Routes.walletBalance,
      page: () => WalletBalanceScreen(),
      binding: WalletBalanceBinding(),
    ),
    GetPage(
      name: Routes.addTransaction,
      page: () => AddTransactionScreen(),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: Routes.editTransaction,
      page: () => AddTransactionScreen(
        trans: Get.arguments,
      ),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: Routes.event,
      page: () => EventScreen(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.addEvent,
      page: () => AddEventScreen(),
    ),
    GetPage(
      name: Routes.editEvent,
      page: () => AddEventScreen(editEvent: Get.arguments),
    ),
    GetPage(name: Routes.selectEvent, page: () => EventScreen(), binding: EventBinding()),
    GetPage(
      name: Routes.myWallets,
      page: () => MyWalletsScreen(),
      binding: MyWalletsBinding(),
    ),
    GetPage(
      name: Routes.addWallet,
      binding: AddWalletBinding(),
      page: () => AddWalletScreen(),
    ),
    GetPage(
      name: Routes.editWallet,
      binding: AddWalletBinding(),
      page: () => AddWalletScreen(wallet: Get.arguments),
    ),
    GetPage(
      name: Routes.categories,
      page: () => CategoriesScreen(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.categorySelector,
      page: () => CategoriesScreen(
        isCategorySelector: true,
      ),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.categorySelector4Budget,
      page: () => CategoriesScreen(
        hideIncome: true,
        isCategorySelector: true,
      ),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.selectIcon,
      page: () => IconSelectionScreen(),
    ),
    GetPage(
      name: Routes.addCategory,
      page: () => AddCategoryScreen(),
      binding: AddCategoryBinding(),
    ),
    GetPage(
      name: Routes.amountKeyboard,
      page: () => EnterAmountScreen(currentAmount: Get.arguments),
    ),
    GetPage(
      name: Routes.addChipsScreen,
      page: () => AddPeoplesScreen(),
    ),
    GetPage(
      name: Routes.recurringTransaction,
      page: () => RecurringTransactionScreen(),
      binding: RecurringTransactionBinding(),
    ),
    GetPage(
      name: Routes.addRecurringTransaction,
      page: () => AddTransactionScreen(),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: Routes.editRecurringTransaction,
      page: () => AddTransactionScreen(
        trans: Get.arguments,
      ),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: Routes.appSetting,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.about,
      page: () => AboutPage(),
    ),
    GetPage(
      name: Routes.budget,
      page: () => BudgetScreen(),
      binding: BudgetBinding(),
    ),
    GetPage(
      name: Routes.addBudget,
      page: () => AddBudgetScreen(),
    ),
    GetPage(
      name: Routes.selectTimeRange,
      page: () => SelectTimeRangeScreen(),
    ),
    GetPage(
      name: Routes.budgetDetail,
      page: () => BudgetDetailScreen(
        budget: Get.arguments,
      ),
    ),
    GetPage(
      name: Routes.editBudget,
      page: () => AddBudgetScreen(
        budget: Get.arguments,
      ),
    ),
  ];
}
