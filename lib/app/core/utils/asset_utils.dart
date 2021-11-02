import 'package:flutter/cupertino.dart';
import 'package:keepital/app/core/values/assets.gen.dart';

class AssetUtils {
  static Map<String, dynamic> assets = {
    Assets.iconsCalendar.path: Assets.iconsCalendar,
    Assets.iconsCurrency.path: Assets.iconsCurrency,
    Assets.iconsEvent.path: Assets.iconsEvent,
    Assets.iconsNote.path: Assets.iconsNote,
    Assets.iconsUnknown.path: Assets.iconsUnknown,
    Assets.imagesAppLogoPng.path: Assets.imagesAppLogoPng,
    Assets.imagesAppLogoSvg.path: Assets.imagesAppLogoSvg,
    Assets.imagesCoinLoading.path: Assets.imagesCoinLoading,
    Assets.imagesElectricityBill.path: Assets.imagesElectricityBill,
    Assets.imagesFacebookLogo.path: Assets.imagesFacebookLogo,
    Assets.imagesFinancialGoal.path: Assets.imagesFinancialGoal,
    Assets.imagesGoogleLogo.path: Assets.imagesGoogleLogo,
    Assets.imagesKeepitalLogoPng.path: Assets.imagesKeepitalLogoPng,
    Assets.imagesKeepitalLogoSvg.path: Assets.imagesKeepitalLogoSvg,
    Assets.imagesWalletListIcon.path: Assets.imagesWalletListIcon,
  };

  static dynamic getAsset(String source) => assets[source];
}
