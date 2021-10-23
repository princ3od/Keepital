import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';

var formatter = new DateFormat('yyyy-MM-dd');

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreen createState() => _AddTransactionScreen();
}

class _AddTransactionScreen extends State<AddTransactionScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 0.07 * MediaQuery.of(context).size.height,
        leading: IconButton(
          icon: Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          'add_transaction'.tr,
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                primary: AppColors.primaryColor,
                textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
            onPressed: () {},
            child: Text("save".tr),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0.8), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: TextFormField(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Image.asset(AssetStringsPng.unknownCategory),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'hint_category'.tr,
                                  hintStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color.fromARGB(35, 0, 0, 0))),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Image.asset(AssetStringsPng.note),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'hint_note'.tr,
                                  hintStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color.fromARGB(35, 0, 0, 0))),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Image.asset(AssetStringsPng.calendar),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            child: TextFormField(
                              initialValue: formatter.format(DateTime.now()),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                              },
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 25.0,
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'hint_wallet'.tr,
                                  hintStyle: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color.fromARGB(35, 0, 0, 0))),
                            ))
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0.8), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Image.asset(AssetStringsPng.calendar),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Flexible(
                          flex: 5,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'hint_event'.tr,
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromARGB(35, 0, 0, 0))),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Icon(
                          Icons.people,
                          size: 25.0,
                        ),
                      ),
                      Flexible(
                          flex: 5,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'hint_with'.tr,
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromARGB(35, 0, 0, 0))),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0.8), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: AppColors.primaryColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            )
                          ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('exclude_label'.tr,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, fontSize: 12)),
                          Text(
                            'exclude_description'.tr,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 8,
                                color: Color.fromARGB(127, 0, 0, 0)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Container(
                margin: EdgeInsets.only(left: 50),
                child: Text('suggest_label'.tr)
            ),
            Container(
                margin: EdgeInsets.only(left: 50),
                child: Text('suggest_description'.tr,  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 8,
                    color: Color.fromARGB(255, 0, 0, 0)),
                ))
          ],
        ),
      ),
    );
  }
}
