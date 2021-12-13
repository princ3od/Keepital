import 'package:keepital/app/core/values/assets.gen.dart';

class AssetUtils {
  static Map<String, dynamic> assets = {
    Assets.iconsUnknown.path: Assets.iconsUnknown,
    Assets.inAppIconWalletDefault.path: Assets.inAppIconWalletDefault,
    Assets.inAppIconEducation.path: Assets.inAppIconEducation,
    Assets.inAppIconElectricityBill.path: Assets.inAppIconElectricityBill,
    Assets.inAppIconGasBill.path: Assets.inAppIconGasBill,
    Assets.inAppIconCollectInterest.path: Assets.inAppIconCollectInterest,
    Assets.inAppIconDebtFee.path: Assets.inAppIconDebtFee,
    Assets.inAppIconEntertainmentCost.path: Assets.inAppIconEntertainmentCost,
    Assets.inAppIconFoodAndBeverage.path: Assets.inAppIconFoodAndBeverage,
    Assets.inAppIconGift.path: Assets.inAppIconGift,
    Assets.inAppIconHomeMaintenance.path: Assets.inAppIconHomeMaintenance,
    Assets.inAppIconIncomingTransfer.path: Assets.inAppIconIncomingTransfer,
    Assets.inAppIconInsurance.path: Assets.inAppIconInsurance,
    Assets.inAppIconInternetBill.path: Assets.inAppIconInternetBill,
    Assets.inAppIconInvestment.path: Assets.inAppIconInvestment,
    Assets.inAppIconLift.path: Assets.inAppIconLift,
    Assets.inAppIconLoan.path: Assets.inAppIconLoan,
    Assets.inAppIconMakeup.path: Assets.inAppIconMakeup,
    Assets.inAppIconPayInterest.path: Assets.inAppIconPayInterest,
    Assets.inAppIconPersonalItems.path: Assets.inAppIconPersonalItems,
    Assets.inAppIconPets.path: Assets.inAppIconPets,
    Assets.inAppIconPhoneBill.path: Assets.inAppIconPhoneBill,
    Assets.inAppIconRental.path: Assets.inAppIconRental,
    Assets.inAppIconReply.path: Assets.inAppIconReply,
    Assets.inAppIconSalary.path: Assets.inAppIconSalary,
    Assets.inAppIconSport.path: Assets.inAppIconSport,
    Assets.inAppIconStreaming.path: Assets.inAppIconStreaming,
    Assets.inAppIconTelevisionBill.path: Assets.inAppIconTelevisionBill,
    Assets.inAppIconTransportation.path: Assets.inAppIconTransportation,
    Assets.inAppIconWaterBill.path: Assets.inAppIconWaterBill,
    Assets.inAppIconOutgoingTransfer.path: Assets.inAppIconOutgoingTransfer,
  };

  static dynamic getAsset(String source) => assets[source];
}
