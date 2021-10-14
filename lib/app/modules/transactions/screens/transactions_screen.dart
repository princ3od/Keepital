import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_strings.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppStrings.appName),
      //   bottom: TabBar(
      //     tabs: [
      //       Text('Dec 2021'),
      //       Text('Dec 2021'),
      //       Text('Dec 2021'),
      //       Text('Dec 2021'),
      //       Text('Dec 2021'),
      //     ],
      //     isScrollable: true,
      //     physics: const BouncingScrollPhysics(),
      //     controller: _tabController,
      //   ),
      // ),
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
    );
  }
}
