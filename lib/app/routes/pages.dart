import 'package:get/get.dart';
import 'package:keepital/app/modules/auth/screens/auth_screen.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_binding.dart';
import 'package:keepital/app/modules/first_wallet/screen/first_wallet_screen.dart';
import 'package:keepital/app/modules/home/home_binding.dart';
import 'package:keepital/app/modules/home/screens/home_screen.dart';
import 'package:keepital/app/modules/splash/screens/splash_screen.dart';

part './routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.Home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.Splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.Auth,
      page: () => AuthenticationScreen(),
    ),
    GetPage(
      name: Routes.First_Wallet,
      page: () => FirstWalletScreen(),
      binding: FirstWalletScreenBinding(),
    ),
  ];
}
