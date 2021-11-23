import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';
import 'package:keepital/app/modules/my_wallets/widgets/wallet_card.dart';

class MyWalletsScreen extends StatelessWidget {
  MyWalletsScreen({Key? key}) : super(key: key);
  final MyWalletsController _controller = Get.find<MyWalletsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'My wallets'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textColor,
            ),
            onPressed: () {
              Get.back();
            },
          )),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _controller.wallets.length,
                  itemBuilder: (BuildContext context, int index) => WalletCard(
                    wallet: _controller.wallets.value[index],
                    onTap: () {},
                    onDelete: () {
                      _controller.deleteWallet(_controller.wallets.value[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.navigatoToAddWalletScreen,
        child: Icon(
          Icons.add_outlined,
        ),
      ),
    );
  }
}
