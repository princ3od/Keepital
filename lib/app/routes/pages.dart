import 'package:get/get.dart';
import 'package:keepital/app/modules/auth/auth_binding.dart';
import 'package:keepital/app/modules/auth/screens/auth_screen.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_binding.dart';
import 'package:keepital/app/modules/first_wallet/screen/first_wallet_screen.dart';
import 'package:keepital/app/modules/home/home_binding.dart';
import 'package:keepital/app/modules/home/screens/home_screen.dart';
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
    ),
    GetPage(
      name: Routes.addTransaction,
      page: () => AddTransactionScreen(),
    ),
  ];
}
