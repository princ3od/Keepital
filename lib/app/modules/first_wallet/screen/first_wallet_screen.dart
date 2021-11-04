import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_controller.dart';

class FirstWalletScreen extends StatefulWidget {
  const FirstWalletScreen({Key? key}) : super(key: key);

  @override
  _FirstWalletScreenState createState() => _FirstWalletScreenState();
}

class _FirstWalletScreenState extends State<FirstWalletScreen> {
  final FirstWalletScreenController _controller = Get.find<FirstWalletScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Obx(
          () => _controller.isLoading.value
              ? SpinKitRing(
                  color: AppColors.indicatorCircularColour,
                  size: 50.0,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      "Create your first wallet".tr,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Each wallet represents a source of your money".tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    IconButton(
                        iconSize: 48,
                        icon: Obx(
                          () => (_controller.iconIdAssetGenImage.value.path == "") ? FaIcon(FontAwesomeIcons.wallet) : _controller.iconIdAssetGenImage.value.image(),
                        ),
                        onPressed: () {
                          _controller.showIconCategoryPicker();
                        }),
                    Text(
                      "CHANGE ICON".tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: _controller.walletNameTextEditingController,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Wallet name".tr,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        onTap: () {
                          _controller.showCurrencyPickerOfWalletScreen(context);
                        },
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.left,
                        controller: _controller.currencyTextEditingController,
                        enabled: true,
                        showCursor: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Currency'.tr,
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
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
                    const SizedBox(height: 5),
                    Text(
                      "Make a budget!".tr,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Container(
                      width: 250,
                      child: TextButton(
                        onPressed: () async {
                          await _controller.handAddFirstWallet();
                        },
                        child: Text(
                          "CONTINUE".tr,
                          style: Theme.of(context).textTheme.button,
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
                            AppColors.primaryColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
        ),
      ),
    );
  }
}
