import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/enums/app_enums.dart';

class DefaultLoading extends StatelessWidget {
  final Color? color;
  final double size;
  final LoadingType loadingType;

  const DefaultLoading({Key? key, this.color, this.size = 50, this.loadingType = LoadingType.foldingCube}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingType == LoadingType.foldingCube) {
      return SpinKitFoldingCube(
        color: color ?? AppColors.textColor.withOpacity(0.6),
        size: size,
      );
    }
    return Image.asset(
      AssetStringGif.coinLoading,
      width: size,
      height: size,
    );
  }
}
