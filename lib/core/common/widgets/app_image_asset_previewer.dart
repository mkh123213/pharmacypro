import 'package:flutter/material.dart';

class AppImageAssetPreviewer extends StatelessWidget {
  const AppImageAssetPreviewer(
    this.imagePath, {
    super.key,
    this.radius,

    this.width,
    this.height,
    this.fit,
  });
  final BorderRadiusGeometry? radius;
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          radius ??
          BorderRadius.circular((width != null && width! > 50) ? 20 : 12),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.fill,
      ),
    );
  }
}
