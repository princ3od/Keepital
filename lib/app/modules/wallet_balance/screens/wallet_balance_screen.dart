import 'package:flutter/material.dart';
import 'package:keepital/app/global_widgets/common_app_bar.dart';
import 'package:keepital/app/modules/wallet_balance/wallet_balance_controller.dart';
import 'package:keepital/app/modules/wallet_balance/widgets/adjust_balance_body.dart';
import 'package:get/get.dart';
import 'package:keepital/app/modules/wallet_balance/widgets/exclude_setting.dart';

class WalletBalanceScreen extends StatefulWidget {
  const WalletBalanceScreen({Key? key}) : super(key: key);

  @override
  _WalletBalanceScreenState createState() => _WalletBalanceScreenState();
}

class _WalletBalanceScreenState extends State<WalletBalanceScreen> {
  final WalletBalanceController _controller = Get.find<WalletBalanceController>();
  @override
  void initState() {
    super.initState();
    _controller.initBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Adjust Balance".tr,
        onSaveTap: _controller.onSavePressed,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              AdjustBalanceBody(),
              SizedBox(
                height: 12,
              ),
              ExcludeSetting(
                  title: 'Exclude from report'.tr,
                  subtitle: 'This transaction is not included in Report and Overview.'.tr,
                  onTap: (isChecked) {
                    _controller.onExcludeSettingChanged(isChecked);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
