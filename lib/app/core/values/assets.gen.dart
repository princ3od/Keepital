/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class Assets {
  Assets._();

  /// File path: assets\icons\calendar.png
  static const AssetGenImage iconsCalendar = AssetGenImage('assets/icons/calendar.png');

  /// File path: assets\icons\currency.png
  static const AssetGenImage iconsCurrency = AssetGenImage('assets/icons/currency.png');

  /// File path: assets\icons\event.png
  static const AssetGenImage iconsEvent = AssetGenImage('assets/icons/event.png');

  /// File path: assets\icons\note.png
  static const AssetGenImage iconsNote = AssetGenImage('assets/icons/note.png');

  /// File path: assets\icons\unknown.png
  static const AssetGenImage iconsUnknown = AssetGenImage('assets/icons/unknown.png');

  /// File path: assets\images\app_logo.png
  static const AssetGenImage imagesAppLogoPng = AssetGenImage('assets/images/app_logo.png');

  /// File path: assets\images\app_logo.svg
  static const SvgGenImage imagesAppLogoSvg = SvgGenImage('assets/images/app_logo.svg');

  /// File path: assets\images\coin_loading.gif
  static const AssetGenImage imagesCoinLoading = AssetGenImage('assets/images/coin_loading.gif');

  /// File path: assets\images\electricity_bill.png
  static const AssetGenImage imagesElectricityBill = AssetGenImage('assets/images/electricity_bill.png');

  /// File path: assets\images\facebook_logo.png
  static const AssetGenImage imagesFacebookLogo = AssetGenImage('assets/images/facebook_logo.png');

  /// File path: assets\images\financial_goal.svg
  static const SvgGenImage imagesFinancialGoal = SvgGenImage('assets/images/financial_goal.svg');

  /// File path: assets\images\google_logo.png
  static const AssetGenImage imagesGoogleLogo = AssetGenImage('assets/images/google_logo.png');

  /// File path: assets\images\keepital_logo.png
  static const AssetGenImage imagesKeepitalLogoPng = AssetGenImage('assets/images/keepital_logo.png');

  /// File path: assets\images\keepital_logo.svg
  static const SvgGenImage imagesKeepitalLogoSvg = SvgGenImage('assets/images/keepital_logo.svg');

  /// File path: assets\images\wallet_list_icon.png
  static const AssetGenImage imagesWalletListIcon = AssetGenImage('assets/images/wallet_list_icon.png');
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
