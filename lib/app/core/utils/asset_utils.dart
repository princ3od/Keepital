import 'package:keepital/app/core/values/assets.gen.dart';

class AssetUtils {
  static Map<String, dynamic> assets = {
    Assets.inAppIconWalletDefault.path: Assets.inAppIconWalletDefault,
    Assets.inAppIconEducation.path: Assets.inAppIconEducation,
    Assets.inAppIconElectricityBill.path: Assets.inAppIconElectricityBill,
    Assets.inAppIconGasBill.path: Assets.inAppIconGasBill,
    Assets.iconsUnknown.path: Assets.iconsUnknown,
  };

  static dynamic getAsset(String source) => assets[source];
}
