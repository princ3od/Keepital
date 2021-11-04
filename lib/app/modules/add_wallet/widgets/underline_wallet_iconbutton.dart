import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/assets.gen.dart';

class UnderlineWalletIconButton extends StatelessWidget {
  final VoidCallback onPresed;
  final AssetGenImage? assetGenImage;
  const UnderlineWalletIconButton({Key? key, required this.onPresed, this.assetGenImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onPresed(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            (assetGenImage == null)
                ? Icon(
                    Icons.ac_unit,
                    size: 24,
                  )
                : assetGenImage!.image(width: 24, height: 24),
            Spacer(),
            Container(
              width: 30,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
