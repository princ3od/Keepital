import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/modules/transaction_detail/transaction_detail_controller.dart';
import 'package:keepital/app/routes/pages.dart';

class TransactionDetailAppbar extends StatelessWidget implements PreferredSizeWidget {
  TransactionDetailAppbar({Key? key})
      : _preferedSize = Size.fromHeight(50.0),
        super(key: key);

  final Size _preferedSize;
  final TransactionDetailController controller = Get.find<TransactionDetailController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        splashRadius: 20.0,
        icon: Container(child: Icon(Icons.clear)),
        color: Theme.of(context).iconTheme.color,
        onPressed: () async {
          Get.back();
        },
      ),
      actions: [
        IconButton(
          splashRadius: 20.0,
          icon: Container(child: Icon(Icons.share)),
          color: Theme.of(context).iconTheme.color,
          onPressed: () async {
            Get.back();
          },
        ),
        IconButton(
          splashRadius: 20.0,
          icon: Container(child: Icon(Icons.edit)),
          color: Theme.of(context).iconTheme.color,
          onPressed: controller.navigateToEditTransactionScreen,
        ),
        IconButton(
          splashRadius: 20.0,
          icon: Container(child: Icon(Icons.delete)),
          color: Theme.of(context).iconTheme.color,
          onPressed: () async {
            if (await controller.deleteTransaction()) Get.back();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => _preferedSize;
}
