import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_strings.dart';
import 'package:keepital/app/data/services/theme_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _counter = 0;
  void _incrementCounter() {
    ThemeService.switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    var _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                },
                child: Text('change theme')),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          currentIndex: _counter,
          onTap: (value) {
            if (value == 2) return;
            setState(() {
              _counter = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(FontAwesomeIcons.wallet, size: 20),
                ),
                label: 'Transaction'.tr),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
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
