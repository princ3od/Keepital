import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/modules/first_wallet/first_wallet_controller.dart';
import 'package:keepital/app/modules/first_wallet/widgets/wallet_icon_picker.dart';
import 'package:keepital/app/routes/pages.dart';

class FirstWalletScreen extends StatelessWidget {
  FirstWalletScreen({Key? key}) : super(key: key);

  final FirstWalletScreenController _controller = Get.find<FirstWalletScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Text(
              "Create your first wallet".tr,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 5),
            Text(
              "Each wallet represents a source of your money".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Spacer(),
            Obx(
              () => WalletIconPicker(
                onTap: () async {
                  final result = await Get.toNamed(Routes.selectIcon);
                  if (null != result) {
                    _controller.walletIcon.value = result;
                  }
                },
                iconPath: _controller.walletIcon.value,
              ),
            ),
            const SizedBox(height: 30),
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
                  _controller.showWalletCurrencyPicker(context);
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
            const Spacer(),
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
            const Spacer(flex: 2),
            Container(
              width: 250,
              child: TextButton(
                onPressed: () async {
                  await _controller.handAddFirstWallet();
                },
                child: Obx(
                  () => (_controller.isLoading.value)
                      ? DefaultLoading(size: 12)
                      : Text(
                          "CONTINUE".tr,
                          style: Theme.of(context).textTheme.button,
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
                    AppColors.primaryColor.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
