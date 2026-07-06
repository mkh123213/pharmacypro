import 'package:flutter/material.dart';
import 'package:pharmacypro/core/style/fonts/font_weight_helper.dart';

import '../../extensions/context_extension.dart';
import 'app_top_bar_actions.dart';
import 'text_app.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({this.showMenuButton = false, super.key});

  final bool showMenuButton;

  @override
  Widget build(BuildContext context) {
    final colors = context.color;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: colors.background,
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 380;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                if (showMenuButton)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 15),
                    child: GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Icon(Icons.menu, color: colors.textPrimary),
                    ),
                  ),

                // Expanded(
                //   child: IconButton(
                //     onPressed: () =>
                //     icon: Icon(Icons.menu, color: colors.textPrimary),
                //   ),
                // ),
                if (!showMenuButton) const SizedBox(width: 20),
                Expanded(
                  child: TextApp(
                    text: 'PharmaChain',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeightHelper.extraBold,
                    ),
                  ),
                ),
                AppTopBarActions(showAvatar: !compact),
              ],
            );
          },
        ),
      ),
    );
  }
}
