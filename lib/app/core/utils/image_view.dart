import 'package:flutter/material.dart';
import 'package:keepital/app/core/utils/asset_utils.dart';
import 'package:keepital/app/core/values/assets.gen.dart';

class ImageView extends StatelessWidget {
  const ImageView(
    this.source, {
    Key? key,
    this.size,
    this.width = 100,
    this.height = 100,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final double? size;
  final double? width, height;
  final Color? color;
  final String source;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    if (source.isSvgPath) return (AssetUtils.getAsset(source) as SvgGenImage).svg(width: size ?? width, height: size ?? height, fit: fit, color: color);
    return (AssetUtils.getAsset(source) as AssetGenImage).image(width: size ?? width, height: size ?? height, fit: fit, color: color);
  }
}

extension StringX on String {
  bool get isSvgPath => this.toLowerCase().endsWith('svg');
}
