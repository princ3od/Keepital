import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_strings.dart';
import 'package:keepital/app/modules/home/home_controller.dart';
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
  Widget build(BuildContext context) {
    var _tabController = TabController(length: 5, vsync: this);

    return Scaffold(
      appBar: (_controller.needShowAppBar())
          ? AppBar(
              title: Text(AppStrings.appName),
              bottom: TabBar(
                tabs: [
                  Text('Dec 2021'),
                  Text('Dec 2021'),
                  Text('Dec 2021'),
                  Text('Dec 2021'),
                  Text('Dec 2021'),
                ],
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
              ),
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
                    child: Icon(FontAwesomeIcons.circle, size: 20),
                  ),
                  label: 'Profile'.tr),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 20,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
