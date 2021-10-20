import 'package:get/get.dart';
import 'package:keepital/app/modules/auth/screens/auth_screen.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_binding.dart';
import 'package:keepital/app/modules/first_wallet/screen/first_wallet_screen.dart';
import 'package:keepital/app/modules/home/home_binding.dart';
import 'package:keepital/app/modules/home/screens/home_screen.dart';
import 'package:keepital/app/modules/splash/screens/splash_screen.dart';
import 'package:keepital/app/modules/transaction_detail/screens/transaction_detail_screen.dart';
import 'package:keepital/app/modules/transaction_detail/transaction_detail_binding.dart';

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
    ),
    GetPage(
      name: Routes.auth,
      page: () => AuthenticationScreen(),
    ),
    GetPage(
      name: Routes.firstWallet,
      page: () => FirstWalletScreen(),
      binding: FirstWalletScreenBinding(),
    ),
    GetPage(
        name: Routes.transaction_detail,
        page: () => TransactionDetailScreen(),
        binding: TransactionDetailBinding())
  ];
}
