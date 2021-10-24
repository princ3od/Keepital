import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/global_widgets/default_loading.dart';
import 'package:keepital/app/modules/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final _controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset(AssetStringsPng.logo),
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              flex: 1,
              child: DefaultLoading(loadingType: LoadingType.coinSpining),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Keepital is fetching your data...".tr,
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
