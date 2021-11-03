import 'package:flutter/material.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/modules/first_wallet/widgets/wallet_category_item.dart';

class CategoryPicker extends StatefulWidget {
  final Function(String)? onPicked;
  const CategoryPicker({Key? key, required this.onPicked}) : super(key: key);

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      margin: const EdgeInsets.only(top: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Pick Icon For Your's First Wallet",
              style: AppTheme.currentTheme.textTheme.headline4,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: buildListWalletCategoryItem()),
          ],
        ),
      ),
    );
  }

  Widget buildListWalletCategoryItem() {
    return ListView(
      children: [
        WalletCategoryItem(
          genImage: Assets.imagesGoogleLogo,
          title: "Google icon",
          onPressed: widget.onPicked,
        ),
        WalletCategoryItem(
          genImage: Assets.imagesFacebookLogo,
          title: "Facebook icon",
          onPressed: widget.onPicked,
        ),
        WalletCategoryItem(
          genImage: Assets.imagesCoinLoading,
          title: "Icon Loading",
          onPressed: widget.onPicked,
        ),
      ],
    );
  }
}
