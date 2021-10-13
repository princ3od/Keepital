import 'package:get/get.dart';
import 'package:keepital/app/modules/home/screens/home_screen.dart';

part './routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.Home,
      page: () => HomeScreen(),
    ),
  ];
}
