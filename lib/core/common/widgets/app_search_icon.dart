import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';
import 'package:pharmacypro/core/extensions/context_extension.dart';

class AppSearchIcon extends StatelessWidget {
  const AppSearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),

        child: AppImageAssetPreviewer(context.assets.search, width: 25.w,),
      ),
    );
  }
}
