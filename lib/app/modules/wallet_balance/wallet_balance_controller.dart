import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'widgets/wallets_modal_bottom_sheet.dart';

class WalletBalanceController extends GetxController {
  List<Wallet> wallets = [];
  TextEditingController selectedWalletController = TextEditingController();
  TextEditingController currentBalanceController = TextEditingController();
  var iconImgData = "".obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await WalletProvider().fetchAll().then(
          (value) => wallets = value.values.toList(),
        );
  }

  void showModalBottomShee() {
    Get.bottomSheet(
      WalletsModalsBottomSheet(
        onSelect: (Wallet selectedWallet) async {
          await Future.delayed(
            Duration(milliseconds: 500),
          );
          onCloseModalBottomSheet(selectedWallet);
        },
        wallets: wallets,
      ),
    );
  }

  void onCloseModalBottomSheet(Wallet selectedWallet) {
    Get.back();
    selectedWalletController.text = selectedWallet.name;
    currentBalanceController.text = selectedWallet.amount.toString();
    iconImgData.value = selectedWallet.iconId;
    print(iconImgData.value);
  }
}
