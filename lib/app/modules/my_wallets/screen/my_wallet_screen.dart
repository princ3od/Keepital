import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/modules/my_wallets/my_wallets_controller.dart';
import 'package:keepital/app/modules/my_wallets/widgets/refresh_widget.dart';
import 'package:keepital/app/modules/my_wallets/widgets/wallet_card.dart';

class MyWalletsScreen extends StatefulWidget {
  const MyWalletsScreen({Key? key}) : super(key: key);
  @override
  _MyWalletsScreenState createState() => _MyWalletsScreenState();
}

class _MyWalletsScreenState extends State<MyWalletsScreen> {
  final MyWalletsController _controller = Get.find<MyWalletsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Wallets'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          )),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 3,
              child: Obx(
                () => _controller.isLoading.value
                    ? Container()
                    : RefreshWidget(
                        onRefresh: loadList,
                        child: ListView.builder(
                          itemCount: _controller.userWalletMap.length,
                          itemBuilder: (BuildContext context, int index) => WalletCard(
                            wallet: _controller.userWalletMap[index],
                            onTap: () {},
                          ),
                        ),
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.handingAddNewWallet,
        child: Icon(
          Icons.add_outlined,
          size: 30,
        ),
      ),
    );
  }

  Future loadList() async {
    await _controller.fetchUserWallets();
  }
}