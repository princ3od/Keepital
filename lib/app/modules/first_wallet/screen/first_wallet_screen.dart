import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_strings.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_controller.dart';
import 'package:currency_picker/currency_picker.dart';

class FirstWalletScreen extends StatefulWidget {
  const FirstWalletScreen({Key? key}) : super(key: key);

  @override
  _FirstWalletScreenState createState() => _FirstWalletScreenState();
}

class _FirstWalletScreenState extends State<FirstWalletScreen> {
  final FirstWalletScreenController _controller =
      Get.find<FirstWalletScreenController>();

  final walletNameTextEditingController = TextEditingController();
  final currencyTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(65, 102, 66, 69),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Create your first wallet".tr,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Each wallet represents a source of your money".tr,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF38305F),
                ),
              ),
              Spacer(),
              IconButton(
                  iconSize: 48,
                  icon: FaIcon(FontAwesomeIcons.wallet),
                  onPressed: () {
                    print("Pressed");
                  }),
              Spacer(),
              Text(
                "CHANGE ICON".tr,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Wallet name".tr),
              ),
              Spacer(),
              TextField(
                onTap: () =>
                    {_controller.showCurrencyPickerOfWalletScreen(context)},
                textAlign: TextAlign.center,
                controller: currencyTextEditingController,
                enabled: true,
                showCursor: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Currency'.tr,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
              Spacer(),
              Text(
                "Money tip:".tr,
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(),
              Text(
                "Make a budget!".tr,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Container(
                width: 250,
                height: 32,
                child: TextButton(
                  onPressed: () => {},
                  child: Text(
                    "CONTINUE".tr,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF38305F),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFF38305F).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
