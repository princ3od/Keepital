import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/assets.gen.dart';

class UnderlineWalletIconButton extends StatelessWidget {
  final VoidCallback onPresed;
  final String? assetGenImagePath;
  const UnderlineWalletIconButton({Key? key, required this.onPresed, this.assetGenImagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      child: InkWell(
        onTap: () => onPresed(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 5,
            ),
            (assetGenImagePath == null)
                ? Icon(
                    Icons.ac_unit,
                    size: 24,
                  )
                : Image.asset(
                    assetGenImagePath!,
                    width: 24,
                    height: 24,
                  ),
            Spacer(),
            Divider(
              thickness: 2,
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
