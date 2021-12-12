import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/global_widgets/user_avatar.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
import 'package:keepital/app/modules/home/widgets/top_bar.dart';
import 'package:keepital/app/modules/planning/screens/planning_screen.dart';
import 'package:keepital/app/modules/profile/screens/profile_screen.dart';
import 'package:keepital/app/modules/report/screens/report_screen.dart';
import 'package:keepital/app/modules/transactions/screens/transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.tabController = TabController(length: _controller.getTabBarLength(), vsync: this, initialIndex: _controller.getInitialTabBarIndex()).obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _controller.needShowAppBar()
          ? TopBar(
              selectTimeRangeCallBack: selectTimeRangeCallBack,
              selectWalletCallBack: () async {
                await _controller.reloadTransList();
              },
            )
          : null,
      body: PageView(
        controller: _controller.pageController,
        onPageChanged: (value) {
          _controller.onPageChanged(value);
          setState(() {});
        },
        children: [
          TransactionsScreen(),
          ReportScreen(),
          PlanningScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: _controller.tabIndex.value,
            onTap: _controller.onTabChanged,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(FontAwesomeIcons.wallet, size: 20),
                  ),
                  label: 'Transactions'.tr),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(FontAwesomeIcons.chartPie, size: 20),
                  ),
                  label: 'Report'.tr),
              BottomNavigationBarItem(
                icon: const SizedBox(),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(FontAwesomeIcons.suitcase, size: 20),
                  ),
                  label: 'Planning'.tr),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: UserAvatar(
                      borderWidth: (_controller.tabIndex.value == AppValue.profileTabIndex) ? 1.6 : 0.6,
                      size: 10,
                      user: AuthService.instance.currentUser!,
                    ),
                  ),
                  label: 'Profile'.tr),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.onAddTransaction(),
        child: Icon(
          Icons.add,
          size: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  void selectTimeRangeCallBack(TimeRange range) {
    if (range == TimeRange.all) {
      _controller.tabController.value = TabController(length: 1, vsync: this, initialIndex: _controller.getInitialTabBarIndex());
    } else
      _controller.tabController.value = TabController(length: 20, vsync: this, initialIndex: _controller.getInitialTabBarIndex());
  }
}
