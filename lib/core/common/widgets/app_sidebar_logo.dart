import 'package:flutter/material.dart';
import 'package:pharmacypro/core/common/widgets/app_image_asset_previewer.dart';

import '../../extensions/context_extension.dart';
import 'text_app.dart';

class AppSidebarLogo extends StatelessWidget {
  const AppSidebarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: [
          AppImageAssetPreviewer(context.assets.appLogo, width: 48, height: 48),
          const SizedBox(width: 12),
          Expanded(
            child: TextApp(
              text: 'PharmaChain',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              theme: TextStyle(
                color: colors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
