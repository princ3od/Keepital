import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/modules/event/widgets/finished_tab.dart';
import 'package:keepital/app/modules/event/widgets/on_going_tab.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  String dropdownValue = 'WalletOne';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.grey[100],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'event'.tr,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            actions: <Widget>[
              Container(height: 30, width: 30, child: Image.asset(AssetStringsPng.walletList)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['WalletOne', 'WalletTwo', 'WallerThree', 'WalletFour'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
            bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.bodyText1,
              tabs: [
                Tab(
                  child: Text("on_going".tr),
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Tab(
                  child: Text("finished".tr),
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OnGoingTab(),
              FinishedTab(),
            ],
          )),
    );
  }
}
